defmodule XrcApi.Task do
  def work do
    # File.write("/tmp/quantum_phoenix.txt", "#{Timex.now}", [:append])
    IO.puts("Cron job started -> #{Timex.now}")

    case XrcApi.Currency.ApiCaller.get_data("latest") do
      {:ok, response_body} ->
        case Jason.decode(response_body) do
          {:ok, decoded} ->
            base = decoded["base"]
            date_rate = decoded["date"]
            rates = decoded["rates"]

            for {currency, rate} <- rates do
              key = base <> currency
              rate_attrs = %{
                base: base,
                currency: currency,
                rate: rate,
                date_rate: date_rate,
                base_currency: key
              }

              result =
                case XrcApi.Repo.get_by(XrcApi.Exchange.Rate, base_currency: key) do
                  nil  -> XrcApi.Exchange.Rate.changeset(%XrcApi.Exchange.Rate{},rate_attrs)
                  the_rate -> XrcApi.Exchange.Rate.changeset(the_rate, rate_attrs)
                end
                |> XrcApi.Repo.insert_or_update

              case result do
                {:ok, model}        -> IO.puts("Inserted or updated with success")
                {:error, changeset} -> IO.puts("Something went wrong")
              end

            end

          {:error, _} ->
            IO.puts("Failed to decode JSON response.")
        end

      {:error, reason} ->
        IO.puts("API call failed: #{inspect(reason)}")
    end
  end
end
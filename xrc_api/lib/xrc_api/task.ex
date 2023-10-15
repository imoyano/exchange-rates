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

            # Iterate over the rates and insert records into the database
            for {currency, rate} <- rates do

              rate_attrs = %{
                base: base,
                currency: currency,
                rate: rate,
                date_rate: date_rate
              }

              # Cast the struct to a changeset for validation
              changeset = XrcApi.Exchange.Rate.changeset(%XrcApi.Exchange.Rate{}, rate_attrs)

              case XrcApi.Repo.insert(changeset) do
                {:ok, _record} ->
                  IO.puts("Record inserted successfully: #{currency}")
                {:error, changeset} ->
                  IO.puts("Failed to insert record: #{currency}")
                # Handle the error or log it as needed
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
defmodule XrcApi.Currency.ApiCaller do

  @api_base_url "http://api.exchangeratesapi.io/v1/"
  @access_key "access_key=f5225b440ef028e2271582897fe97470"

  def get_data(path) do
    IO.puts("Start get_data")
    url = "#{@api_base_url}/#{path}?#{@access_key}"
    IO.puts("url: #{url}")
    headers = %{"Authorization": "Bearer YOUR_API_KEY"} # Add your API authorization header if needed

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Request failed with status code #{status_code}: #{body}"}

      {:error, reason} ->
        {:error, "Request failed: #{inspect(reason)}"}
    end
  end

end
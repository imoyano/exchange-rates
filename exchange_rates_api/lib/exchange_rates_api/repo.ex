defmodule ExchangeRatesApi.Repo do
  use Ecto.Repo,
    otp_app: :exchange_rates_api,
    adapter: Ecto.Adapters.Postgres
end

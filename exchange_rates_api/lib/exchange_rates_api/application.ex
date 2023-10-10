defmodule ExchangeRatesApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ExchangeRatesApiWeb.Telemetry,
      ExchangeRatesApi.Repo,
      {DNSCluster, query: Application.get_env(:exchange_rates_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ExchangeRatesApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ExchangeRatesApi.Finch},
      # Start a worker by calling: ExchangeRatesApi.Worker.start_link(arg)
      # {ExchangeRatesApi.Worker, arg},
      # Start to serve requests, typically the last entry
      ExchangeRatesApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExchangeRatesApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExchangeRatesApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule XrcApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {XrcApi.Scheduler, []},
      # Start the Ecto repository
      XrcApi.Repo,
      # Start the Telemetry supervisor
      XrcApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: XrcApi.PubSub},
      # Start the Endpoint (http/https)
      XrcApiWeb.Endpoint
      # Start a worker by calling: XrcApi.Worker.start_link(arg)
      # {XrcApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: XrcApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    XrcApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

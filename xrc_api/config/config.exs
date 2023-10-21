# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :xrc_api,
  ecto_repos: [XrcApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :xrc_api, XrcApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4+shpvMXceQDx9agVOkPegwjYflPN95z6S174RhNyH3Fdcpy9dmXodGybJ/mbzJ2",
  render_errors: [view: XrcApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: XrcApi.PubSub,
  live_view: [signing_salt: "Nrervr8W"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :logger, :info_log,
  path: "/tmp/xrc_logs/info.log", # Specify the path to your info-level log file.
  level: :info

config :logger, :error_log,
  path: "/tmp/xrc_logs/error.log", # Specify the path to your error-level log file.
  level: :error

config :xrc_api, XrcApi.Scheduler,
  jobs: [
    phoenix_job: [
      schedule: "0 */8 * * *",
      task: {XrcApi.Task, :work, []},
    ]
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

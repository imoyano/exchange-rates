defmodule XrcApi.Repo do
  use Ecto.Repo,
    otp_app: :xrc_api,
    adapter: Ecto.Adapters.Postgres
end

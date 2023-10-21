defmodule XrcApiWeb.Router do
  use XrcApiWeb, :router
#
#  # Add this import at the top of your router module
#  import Phoenix.Endpoint, only: [serve: 2]
#
#  # Inside the router module, in the browser pipeline, add the following line to serve static assets:
#  pipeline :browser do
#    # ...
#    plug(:put_layout, {XrcApiWeb.LayoutView, :app})
#    plug(:put_root_layout, {XrcApiWeb.LayoutView, :root})
#    plug(:put_status, :ok)
#    plug(:put_view, XrcApiWeb.CalculatorView)
#    plug(:put_flash)
#    plug(:put_session)
#    plug(:put_user)
#    plug(:protect_from_forgery)
#    plug(:put_secure_browser_headers)
#
#    # Add this line to serve static assets from the "priv/static" directory
#    plug(Plug.Static, at: "/static", from: :xrc_api, gzip: false)
#  end


  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    # Add this line to serve static assets from the "priv/static" directory
    plug(Plug.Static, at: "/static", from: :xrc_api, gzip: false)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", XrcApiWeb do
    pipe_through :browser
    get "/", CalculatorController, :index
  end

  scope "/api", XrcApiWeb do
    pipe_through :api
    resources "/rates", RateController, except: [:new, :edit]
    post "/rates/exchange", RateController, :exchange
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: XrcApiWeb.Telemetry
    end
  end
end

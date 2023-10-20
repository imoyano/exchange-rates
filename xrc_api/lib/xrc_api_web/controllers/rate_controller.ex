defmodule XrcApiWeb.RateController do
  use XrcApiWeb, :controller

  alias XrcApi.Exchange
  alias XrcApi.Exchange.Rate

  action_fallback XrcApiWeb.FallbackController

  def index(conn, _params) do
    rates = Exchange.list_rates()
    render(conn, "index.json", rates: rates)
  end

  def create(conn, params) do
    with {:ok, %Rate{} = rate} <- Exchange.create_rate(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.rate_path(conn, :show, rate))
      |> render("show.json", rate: rate)
    end
  end

  def show(conn, %{"id" => id}) do
    rate = Exchange.get_rate!(id)
    render(conn, "show.json", rate: rate)
  end

  def update(conn, %{"id" => id} = params) do
    rate = Exchange.get_rate!(id)

    with {:ok, %Rate{} = rate} <- Exchange.update_rate(rate, params) do
      render(conn, "show.json", rate: rate)
    end
  end

  def delete(conn, %{"id" => id}) do
    rate = Exchange.get_rate!(id)

    with {:ok, %Rate{}} <- Exchange.delete_rate(rate) do
      send_resp(conn, :no_content, "")
    end
  end

  @doc """
  Calculate the exchange rate.

  Parameters:
  - amount: Amount to be exchanged
  - origin_currency: The currency from which the amount is converted
  - goal_currency: The currency to which the amount is converted

  ## Examples

      iex> exchange(conn, %{amount: 100, origin_currency: "USD", goal_currency: "EUR"})
      {:ok, %{"result" => 83.33}}

  """
  def exchange(conn, %{"amount" => amount_str, "origin_currency" => origin_currency, "goal_currency" => goal_currency}) do
    case calculate_exchange_rate(amount_str, origin_currency, goal_currency) do
      {:ok, result} ->
        conn
        |> put_status(:ok)
        |> json(%{"result" => result})

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{"error" => reason})
    end
  end

  defp calculate_exchange_rate(amount_str, origin_currency, goal_currency) do
    # Convert the amount from a string to a float
    case Float.parse(amount_str) do
      {amount, _} when is_float(amount) ->
        # Calculate the result based on the origin and goal currencies
        rate_origin = XrcApi.Repo.get_by(XrcApi.Exchange.Rate, base_currency: "EUR#{origin_currency}")
        rate_goal = XrcApi.Repo.get_by(XrcApi.Exchange.Rate, base_currency: "EUR#{goal_currency}")
        result = amount * rate_goal.rate / rate_origin.rate

        {:ok, result}

      _ ->
        {:error, "Invalid amount"}
    end
  end
end

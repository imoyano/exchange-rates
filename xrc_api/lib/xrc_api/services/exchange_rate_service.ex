defmodule XrcApi.ExchangeRateService do
  def calculate_exchange_rate(amount_str, origin_currency, goal_currency) do
    case Float.parse(amount_str) do
      {amount, _} when is_float(amount) ->
        rate_origin = XrcApi.Repo.get_by(XrcApi.Exchange.Rate, base_currency: "EUR#{origin_currency}")
        rate_goal = XrcApi.Repo.get_by(XrcApi.Exchange.Rate, base_currency: "EUR#{goal_currency}")
        result = amount * rate_goal.rate / rate_origin.rate

        {:ok, Float.round(result, 2)}

      _ ->
        {:error, "Invalid amount"}
    end
  end
end

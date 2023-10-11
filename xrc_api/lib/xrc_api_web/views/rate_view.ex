defmodule XrcApiWeb.RateView do
  use XrcApiWeb, :view
  alias XrcApiWeb.RateView

  def render("index.json", %{rates: rates}) do
    %{data: render_many(rates, RateView, "rate.json")}
  end

  def render("show.json", %{rate: rate}) do
    %{data: render_one(rate, RateView, "rate.json")}
  end

  def render("rate.json", %{rate: rate}) do
    %{id: rate.id,
      base: rate.base,
      currency: rate.currency,
      rate: rate.rate,
      date_rate: rate.date_rate}
  end
end

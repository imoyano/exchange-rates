defmodule XrcApi.ExchangeRateServiceTest do
  use ExUnit.Case
  use XrcApiWeb.ConnCase

  alias XrcApi.ExchangeRateService

  @exchange_attrs %{
    base: "EUR",
    currency: "EUR",
    rate: 1,
    date_rate: "some date_rate",
    base_currency: "EUREUR"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "calculate exchange" do
    test "calculate_exchange_rate with valid inputs", %{conn: conn}  do
      conn = post(conn, Routes.rate_path(conn, :create), @exchange_attrs)
      assert {:ok, result} = ExchangeRateService.calculate_exchange_rate("83.33", "EUR", "EUR")
      assert result == 83.33  # The expected result for 100.0 USD to EUR
    end

    test "calculate_exchange_rate with invalid amount" do
      assert {:error, reason} = ExchangeRateService.calculate_exchange_rate("invalid", "USD", "EUR")
      assert reason == "Invalid amount"
    end
  end
end

defmodule XrcApiWeb.RateControllerTest do
  use XrcApiWeb.ConnCase

  alias XrcApi.Exchange
  alias XrcApi.Exchange.Rate

  @create_attrs %{
    base: "some base",
    currency: "some currency",
    rate: 120.5,
    date_rate: "some date_rate",
    base_currency: "EURCLP"
  }
  @update_attrs %{
    base: "some updated base",
    currency: "some updated currency",
    rate: 456.7,
    date_rate: "some updated date_rate",
    base_currency: "EURCLP"
  }
  @invalid_attrs %{
    base: "some updated base",
    currency: "some updated currency",
    rate: 456.7,
    date_rate: "some updated date_rate"
  }
  @exchange_attrs %{
    base: "EUR",
    currency: "EUR",
    rate: 120,
    date_rate: "some date_rate",
    base_currency: "EUREUR"
  }

  def fixture(:rate) do
    {:ok, rate} = Exchange.create_rate(@create_attrs)
    rate
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all rates", %{conn: conn} do
      conn = get(conn, Routes.rate_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create rate" do
    test "renders rate when data is valid", %{conn: conn} do
      conn = post(conn, Routes.rate_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.rate_path(conn, :show, id))

      assert %{
               "id" => id,
               "base" => "some base",
               "currency" => "some currency",
               "date_rate" => "some date_rate",
               "rate" => 120.5,
               "base_currency" => "EURCLP"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "update rate" do
    setup [:create_rate]

    test "renders rate when data is valid", %{conn: conn, rate: %Rate{id: id} = rate} do
      conn = put(conn, Routes.rate_path(conn, :update, rate), @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.rate_path(conn, :show, id))

      assert %{
               "id" => id,
               "base" => "some updated base",
               "currency" => "some updated currency",
               "date_rate" => "some updated date_rate",
               "rate" => 456.7
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete rate" do
    setup [:create_rate]

    test "deletes chosen rate", %{conn: conn, rate: rate} do
      conn = delete(conn, Routes.rate_path(conn, :delete, rate))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.rate_path(conn, :show, rate))
      end
    end
  end

  describe "exchange" do
    test "calculates exchange rate with valid params", %{conn: conn} do

      conn = post(conn, Routes.rate_path(conn, :create), @exchange_attrs)

      params = %{
        "amount" => "100.0",
        "origin_currency" => "EUR",
        "goal_currency" => "EUR"
      }

      conn = post(conn, Routes.rate_path(conn, :exchange), params)

      assert conn.status == 200
      assert %{"result" => result} = json_response(conn, 200)

      # Add more assertions as needed to verify the calculated result
      assert Float.round(result, 2) == 100.0
    end
  end

  defp create_rate(_) do
    rate = fixture(:rate)
    %{rate: rate}
  end
end

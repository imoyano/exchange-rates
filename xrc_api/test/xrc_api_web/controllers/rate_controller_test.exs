defmodule XrcApiWeb.RateControllerTest do
  use XrcApiWeb.ConnCase

  alias XrcApi.Exchange
  alias XrcApi.Exchange.Rate

  @create_attrs %{
    base: "some base",
    currency: "some currency",
    rate: 120.5,
    date_rate: "some date_rate"
  }
  @update_attrs %{
    base: "some updated base",
    currency: "some updated currency",
    rate: 456.7,
    date_rate: "some updated date_rate"
  }
  @invalid_attrs %{base: nil, currency: nil, rate: nil, date_rate: nil}

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
      conn = post(conn, Routes.rate_path(conn, :create), rate: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.rate_path(conn, :show, id))

      assert %{
               "id" => id,
               "base" => "some base",
               "currency" => "some currency",
               "date_rate" => "some date_rate",
               "rate" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.rate_path(conn, :create), rate: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update rate" do
    setup [:create_rate]

    test "renders rate when data is valid", %{conn: conn, rate: %Rate{id: id} = rate} do
      conn = put(conn, Routes.rate_path(conn, :update, rate), rate: @update_attrs)
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

    test "renders errors when data is invalid", %{conn: conn, rate: rate} do
      conn = put(conn, Routes.rate_path(conn, :update, rate), rate: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
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

  defp create_rate(_) do
    rate = fixture(:rate)
    %{rate: rate}
  end
end

defmodule XrcApi.ExchangeTest do
  use XrcApi.DataCase

  alias XrcApi.Exchange

  describe "rates" do
    alias XrcApi.Exchange.Rate

    @valid_attrs %{base: "some base", currency: "some currency", rate: 120.5, date_rate: "some date_rate", base_currency: "EURCLP"}
    @update_attrs %{base: "some updated base", currency: "some updated currency", rate: 456.7, date_rate: "some updated date_rate", base_currency: "EURCLP"}
    @invalid_attrs %{base: nil, currency: nil, rate: nil, date_rate: nil, base_currency: nil}

    def rate_fixture(attrs \\ %{}) do
      {:ok, rate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Exchange.create_rate()

      rate
    end

    test "list_rates/0 returns all rates" do
      rate = rate_fixture()
      assert Exchange.list_rates() == [rate]
    end

    test "get_rate!/1 returns the rate with given id" do
      rate = rate_fixture()
      assert Exchange.get_rate!(rate.id) == rate
    end

    test "create_rate/1 with valid data creates a rate" do
      assert {:ok, %Rate{} = rate} = Exchange.create_rate(@valid_attrs)
      assert rate.base == "some base"
      assert rate.currency == "some currency"
      assert rate.rate == 120.5
      assert rate.date_rate == "some date_rate"
    end

    test "create_rate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exchange.create_rate(@invalid_attrs)
    end

    test "update_rate/2 with valid data updates the rate" do
      rate = rate_fixture()
      assert {:ok, %Rate{} = rate} = Exchange.update_rate(rate, @update_attrs)
      assert rate.base == "some updated base"
      assert rate.currency == "some updated currency"
      assert rate.rate == 456.7
      assert rate.date_rate == "some updated date_rate"
    end

    test "update_rate/2 with invalid data returns error changeset" do
      rate = rate_fixture()
      assert {:error, %Ecto.Changeset{}} = Exchange.update_rate(rate, @invalid_attrs)
      assert rate == Exchange.get_rate!(rate.id)
    end

    test "delete_rate/1 deletes the rate" do
      rate = rate_fixture()
      assert {:ok, %Rate{}} = Exchange.delete_rate(rate)
      assert_raise Ecto.NoResultsError, fn -> Exchange.get_rate!(rate.id) end
    end

    test "change_rate/1 returns a rate changeset" do
      rate = rate_fixture()
      assert %Ecto.Changeset{} = Exchange.change_rate(rate)
    end
  end
end

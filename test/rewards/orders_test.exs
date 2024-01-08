defmodule Rewards.OrdersTest do
  use Rewards.DataCase

  alias Rewards.Orders

  describe "orders" do
    alias Rewards.Orders.Order

    import Rewards.OrdersFixtures
    import Rewards.CoreFixtures

    @create_attrs %{
      "order" => %{
        "currency" => "JPY",
        "paid" => "120.5"
      },
      "customer" => %{
        "email" => "xyz@example.com",
        "phone" => "+811234567890"
      }
    }
    @invalid_attrs %{}

    setup do
      setting = setting_fixture(%{reward_percentage: "1"})
      {:ok, setting: setting}
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %{order: %Order{} = order}} = Orders.create_order(@create_attrs)
      assert order.currency == "JPY"
      assert order.paid == Decimal.new("120.5")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, _, %Ecto.Changeset{}, _} = Orders.create_order(@invalid_attrs)
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end

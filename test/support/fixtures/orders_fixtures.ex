defmodule Rewards.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rewards.Orders` context.
  """

  import Rewards.{AccountFixtures, CoreFixtures}

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    setting_fixture(%{reward_percentage: "1"})
    customer = customer_fixture()

    {:ok, %{order: order}} =
      attrs
      |> Enum.into(%{
        "order" => %{
          "currency" => "JPY",
          "paid" => "120.5"
        },
        "customer" => %{
          "email" => customer.email,
          "phone" => customer.phone
        }
      })
      |> Rewards.Orders.create_order()

    order
  end
end

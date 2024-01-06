defmodule Rewards.OrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rewards.Orders` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        paid: "120.5"
      })
      |> Rewards.Orders.create_order()

    order
  end
end

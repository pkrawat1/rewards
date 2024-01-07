defmodule RewardsWeb.OrderJSON do
  alias Rewards.Orders.Order

  @doc """
  Renders a single order.
  """
  def show(%{order: order}) do
    %{data: data(order)}
  end

  defp data(%Order{} = order) do
    %{
      id: order.id,
      paid: order.paid,
      currency: order.currency
    }
  end
end

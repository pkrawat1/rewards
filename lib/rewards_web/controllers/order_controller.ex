defmodule RewardsWeb.OrderController do
  use RewardsWeb, :controller

  alias Rewards.Orders
  alias Rewards.Orders.Order

  action_fallback RewardsWeb.FallbackController

  def create(conn, %{"order" => order_params}) do
    with {:ok, %Order{} = order} <- Orders.create_order(order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/orders/#{order}")
      |> render(:show, order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order!(id)
    render(conn, :show, order: order)
  end
end

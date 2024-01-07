defmodule RewardsWeb.OrderController do
  use RewardsWeb, :controller

  alias Rewards.Orders

  action_fallback RewardsWeb.FallbackController

  def create(conn, %{"order" => order_params}) do
    with {:ok, multi} <- Orders.create_order(order_params),
         {:ok, %{order: order}} <- multi do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/orders/#{order}")
      |> render(:show, order: order)
    else
      {:error, _, changeset} -> {:error, changeset}
      e -> e
    end
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order!(id)
    render(conn, :show, order: order)
  end
end

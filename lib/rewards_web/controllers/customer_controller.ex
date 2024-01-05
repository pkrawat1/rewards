defmodule RewardsWeb.CustomerController do
  use RewardsWeb, :controller

  alias Rewards.{Account, Reward}

  action_fallback RewardsWeb.FallbackController

  def balance(conn, %{"identifier" => identifier}) do
    with %{} = customer <- Account.get_customer_by_identifier(identifier),
         latest_points_history <- Reward.get_customer_latest_points_history(customer.id) do
      render(conn, :balance, latest_points_history: latest_points_history, customer: customer)
    else
      _ ->
        {:error, :not_found}
    end
  end

  def update_balance(conn, %{"identifier" => identifier, "transaction" => transaction_params}) do
    with %{} = customer <- Account.get_customer_by_identifier(identifier),
         points_history_attrs <- Map.put_new(transaction_params, "customer_id", customer.id),
         {:ok, latest_points_history} <- Reward.create_points_history(points_history_attrs) do
      render(conn, :balance, latest_points_history: latest_points_history, customer: customer)
    else
      nil ->
        {:error, :not_found}

      e ->
        e
    end
  end
end

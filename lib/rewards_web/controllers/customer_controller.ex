defmodule RewardsWeb.CustomerController do
  use RewardsWeb, :controller

  alias Rewards.{Account, Reward}

  action_fallback RewardsWeb.FallbackController

  def balance(conn, %{"identifier" => identifier}) do
    customer = Account.get_customer_by_identifier(identifier)
    latest_points_history = Reward.get_customer_latest_points_history(customer.id)
    render(conn, :balance, latest_points_history: latest_points_history, customer: customer)
  end
end

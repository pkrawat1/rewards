defmodule RewardsWeb.CustomerController do
  use RewardsWeb, :controller

  alias Rewards.Account

  action_fallback RewardsWeb.FallbackController

  def balance(conn, %{"identifier" => identifier}) do
    balance = Account.get_customer_balance!(identifier)
    render(conn, :balance, balance: balance)
  end
end

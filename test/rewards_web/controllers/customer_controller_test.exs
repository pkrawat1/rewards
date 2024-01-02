defmodule RewardsWeb.CustomerControllerTest do
  use RewardsWeb.ConnCase

  import Rewards.AccountFixtures

  alias Rewards.Account.Customer

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end
end

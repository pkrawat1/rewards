defmodule RewardsWeb.CustomerControllerTest do
  use RewardsWeb.ConnCase

  import Rewards.{AccountFixtures, RewardFixtures}

  alias Rewards.Account
  alias Rewards.Account.Customer

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show customer" do
    setup [:create_customer]

    test "renders customer balance", %{conn: conn, customer: %Customer{id: id} = customer} do
      identifier = Account.get_customer_identifier(customer)
      points_history_fixture(%{customer_id: id, points: 200})
      :timer.sleep(100)
      points_history_fixture(%{customer_id: id, points: 300})
      :timer.sleep(100)
      points_history_fixture(%{customer_id: id, points: 100, transaction_type: :spent})
      conn = get(conn, ~p"/api/customers/#{identifier}/balance")

      assert %{
               "balance" => %{
                 "balance" => "400",
                 "last_transaction_points" => "100",
                 "last_transaction_type" => "spent"
               },
               "customer" => %{
                 "email" => customer.email,
                 "phone" => customer.phone,
                 "id" => customer.id
               }
             } == json_response(conn, 200)["data"]
    end
  end

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end
end

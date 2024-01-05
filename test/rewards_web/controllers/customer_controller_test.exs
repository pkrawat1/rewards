defmodule RewardsWeb.CustomerControllerTest do
  use RewardsWeb.ConnCase

  import Rewards.{AccountFixtures, RewardFixtures}

  alias Rewards.Account
  alias Rewards.Account.Customer

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show customer balance" do
    setup [:create_customer]

    test "renders error for invalid params", %{conn: conn} do
      conn = get(conn, ~p"/api/customers/invalid/balance")
      assert %{"detail" => "Not Found"} == json_response(conn, 404)["errors"]
    end

    test "renders customer balance", %{conn: conn, customer: %Customer{id: id} = customer} do
      identifier = Account.get_customer_identifier(customer)
      points_history_fixture(%{customer_id: id, points: 200})
      :timer.sleep(1000)
      points_history_fixture(%{customer_id: id, points: 300})
      :timer.sleep(1000)
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

  describe "update customer balance" do
    setup [:create_customer]

    test "renders error for invalid params", %{conn: conn, customer: customer} do
      identifier = Account.get_customer_identifier(customer)

      conn =
        post(conn, ~p"/api/customers/invalid/balance", %{
          "transaction" => %{
            "transaction_type" => "earned",
            "points" => "0"
          }
        })

      assert %{"detail" => "Not Found"} == json_response(conn, 404)["errors"]

      [
        {%{},
         %{
           "points" => ["can't be blank"],
           "transaction_type" => ["can't be blank"]
         }},
        {%{
           "transaction_type" => "spent",
           "points" => "10"
         },
         %{
           "balance" => ["must be greater than or equal to 0"]
         }},
        {%{
           "transaction_type" => "invalid",
           "points" => "10"
         },
         %{
           "transaction_type" => ["is invalid"]
         }},
        {%{
           "transaction_type" => "earned",
           "points" => "-10"
         },
         %{
           "points" => ["must be greater than 0"],
           "balance" => ["must be greater than or equal to 0"]
         }}
      ]
      |> Enum.each(fn {params, errors} ->
        conn =
          post(conn, ~p"/api/customers/#{identifier}/balance", %{
            "transaction" => params
          })

        assert errors == json_response(conn, 422)["errors"]
      end)
    end

    test "renders customer balance on update", %{conn: conn, customer: customer} do
      identifier = Account.get_customer_identifier(customer)
      conn = get(conn, ~p"/api/customers/#{identifier}/balance")

      assert %{
               "balance" => %{
                 "balance" => nil,
                 "last_transaction_type" => nil,
                 "last_transaction_points" => nil
               }
             } = json_response(conn, 200)["data"]

      [
        {"earned", "20", "20"},
        {"earned", "100", "120"},
        {"spent", "80", "40"},
        {"spent", "40", "0"},
        {"earned", "200", "200"}
      ]
      |> Enum.each(fn {transaction_type, points, balance} ->
        :timer.sleep(1000)

        conn =
          post(conn, ~p"/api/customers/#{identifier}/balance", %{
            "transaction" => %{
              "transaction_type" => transaction_type,
              "points" => points
            }
          })

        assert %{
                 "balance" => %{
                   "balance" => ^balance,
                   "last_transaction_points" => ^points,
                   "last_transaction_type" => ^transaction_type
                 }
               } = json_response(conn, 200)["data"]
      end)
    end
  end

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end
end

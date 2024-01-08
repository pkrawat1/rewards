defmodule RewardsWeb.CustomerController do
  use RewardsWeb, :controller
  use PhoenixSwagger

  alias Rewards.{Account, Reward}

  action_fallback RewardsWeb.FallbackController

  def swagger_definitions do
    %{
      Balance:
        swagger_schema do
          title("Balance")
          description("Customer Balance")

          properties do
            last_transaction_points(:float, "Last transaction amount")
            last_transaction_type(:string, "Last transaction type")
            balance(:float, "Customer balance")
          end

          example(%{
            balance: 100.00,
            last_transaction_points: 20.00,
            last_transaction_type: "spent"
          })
        end,
      Customer:
        swagger_schema do
          title("Customer")
          description("Customer details")

          properties do
            email(:string, "Customer email")
            phone(:string, "Customer international phone number")
          end

          example(%{
            email: "xyz@abc.com",
            phone: "+91 1234567890"
          })
        end,
      Transaction:
        swagger_schema do
          properties do
            transaction_type(:string, "Transaction type : earned or spent")
            points(:decimal, "Points spent/earned")
          end

          example(%{
            transaction_type: "spent",
            points: "10.00"
          })
        end
    }
  end

  swagger_path :balance do
    get("/customers/{identifier}/balance")
    summary("Get customer balance")

    description("Shows the customer reward points balance")

    tag("Customer")

    operation_id("customer_balance")

    parameters do
      identifier(:path, :string, "Customer email or phone")
    end

    response(
      200,
      "OK",
      swagger_schema do
        properties do
          balance(Schema.ref(:Balance))
          customer(Schema.ref(:Customer))
        end
      end
    )

    response(404, "Not found", Schema.ref(:Error))
  end

  def balance(conn, %{"identifier" => identifier}) do
    with %{} = customer <- Account.get_customer_by_identifier(identifier),
         latest_points_history <- Reward.get_customer_latest_points_history(customer.id) do
      render(conn, :balance, latest_points_history: latest_points_history, customer: customer)
    else
      _ ->
        {:error, :not_found}
    end
  end

  swagger_path :update_balance do
    post("/customers/{identifier}/balance")
    summary("update customer balance")

    description("Updates customer balance by creating new transaction in points history")

    tag("Customer")

    operation_id("update_customer_balance")

    parameters do
      identifier(:path, :string, "Customer email or phone", value: "xyz@abc.com")

      body(
        :body,
        swagger_schema do
          properties do
            transaction(Schema.ref(:Transaction))
          end
        end,
        "New transaction"
      )
    end

    response(
      200,
      "OK",
      swagger_schema do
        properties do
          balance(Schema.ref(:Balance))
          customer(Schema.ref(:Customer))
        end
      end
    )

    response(404, "Not found", Schema.ref(:Error))
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

defmodule RewardsWeb.OrderController do
  use RewardsWeb, :controller

  alias Rewards.Orders

  use PhoenixSwagger

  action_fallback RewardsWeb.FallbackController

  def swagger_definitions do
    %{
      OrderParams:
        swagger_schema do
          title("Order")
          description("Customer Order")

          properties do
            id(:string, "The ID of the order")
            paid(:float, "The amount paid")
            currency(:string, "The currency of the amount paid")
          end

          example(%{
            order: %{id: "ac22d27d-e6ab-4ca4-92b5-b3b8bed42f0c", paid: 1000.00, currency: "JPY"},
            customer: %{email: "xyz@example.com", phone: "+91 1234567890"}
          })
        end,
      Order:
        swagger_schema do
          title("Order")
          description("Customer Order")

          properties do
            id(:string, "The ID of the order")
            paid(:float, "The amount paid")
            currency(:string, "The currency of the amount paid")
          end

          example(%{
            id: "104fd7e0-a188-4ffd-9af7-20d7876f70ab",
            paid: 1000.00,
            currency: "JPY"
          })
        end,
      Error:
        swagger_schema do
          title("Errors")
          description("Error responses from the API")

          properties do
            errors(:object, "The message of the error raised", required: true)
          end
        end
    }
  end

  swagger_path :create do
    post("/orders")
    summary("Create order")

    description(~s[
      This operation finds or creates the customer first.
      Creates the order and assigns to the customer.
      Then calculates the reward points and generates the points history
    ])

    tag("Order")

    operation_id("create_order")

    parameters do
      body(:body, Schema.ref(:OrderParams), "Order Object", required: true)
    end

    response(200, "OK", Schema.ref(:Order))
  end

  def create(conn, params) do
    with {:ok, %{order: order}} <- Orders.create_order(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/orders/#{order}")
      |> render(:show, order: order)
    else
      {:error, _, changeset, _} -> {:error, changeset}
      e -> e
    end
  end

  swagger_path :show do
    get("/orders/{id}")
    summary("Retrieve an order")
    description("Retrieve an order that you have recorded")

    parameters do
      id(:path, :string, "The uuid of the order", required: true)
    end

    response(200, "Ok", Schema.ref(:Order))
    response(404, "Not found", Schema.ref(:Error))
  end

  def show(conn, %{"id" => id}) do
    case Orders.get_order(id) do
      nil -> {:error, :not_found}
      order -> render(conn, :show, order: order)
    end
  end
end

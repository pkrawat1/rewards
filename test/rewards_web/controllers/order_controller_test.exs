defmodule RewardsWeb.OrderControllerTest do
  use RewardsWeb.ConnCase

  @create_attrs %{
    order: %{
      currency: "JPY",
      paid: "120.5"
    },
    customer: %{
      email: "xyz@abc.def",
      phone: "123213231"
    }
  }
  @invalid_attrs %{
    order: %{
      currency: "invalid",
      paid: "-100"
    },
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/orders", order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/orders/#{id}")

      assert %{
               "id" => ^id,
               "currency" => "JPY",
               "paid" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/orders", order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end

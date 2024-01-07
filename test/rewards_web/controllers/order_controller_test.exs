defmodule RewardsWeb.OrderControllerTest do
  use RewardsWeb.ConnCase

  import Rewards.CoreFixtures

  @create_attrs %{
    order: %{
      currency: "JPY",
      paid: "120.5"
    },
    customer: %{
      email: "xyz@abc.def",
      phone: "+12025550431"
    }
  }
  @invalid_attrs_list [
    %{},
    %{
      order: %{
        currency: "JPY",
        paid: "120.5"
      }
    },
    %{
      order: %{
        currency: "JPY",
        paid: "120.5"
      },
      customer: %{
        email: "",
        phone: ""
      }
    },
    %{
      order: %{
        currency: "JPY",
        paid: "120.5"
      },
      customer: %{
        email: "xyz@asd",
        phone: "+12025550431"
      }
    },
    %{
      order: %{
        currency: "JPY",
        paid: "120.5"
      },
      customer: %{
        email: "xyz@def.com",
        phone: "123213231"
      }
    }
  ]

  setup %{conn: conn} do
    setting = setting_fixture(%{reward_percentage: "1"})
    {:ok, conn: put_req_header(conn, "accept", "application/json"), setting: setting}
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
      Enum.each(@invalid_attrs_list, fn invalid_attrs ->
        conn = post(conn, ~p"/api/orders", order: invalid_attrs)
        assert json_response(conn, 422)["errors"] != %{}
      end)
    end
  end
end

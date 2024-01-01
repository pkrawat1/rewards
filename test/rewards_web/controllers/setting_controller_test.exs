defmodule RewardsWeb.SettingControllerTest do
  use RewardsWeb.ConnCase

  import Rewards.CoreFixtures

  @update_attrs %{currency: "JPY", reward_percentage: "20.00"}
  @invalid_attrs %{currency: nil, reward_percentage: nil}
  @invalid_attrs_list [
    @invalid_attrs,
    %{@invalid_attrs | currency: "invalid", reward_percentage: "20"},
    %{@invalid_attrs | currency: "JPY", reward_percentage: "-1"},
    %{@invalid_attrs | currency: "JPY", reward_percentage: "101"}
  ]

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "show setting" do
    setup [:create_setting]

    test "renders setting", %{conn: conn, setting: setting} do
      conn = get(conn, ~p"/api/settings")

      assert %{
               "currency" => setting.currency,
               "reward_percentage" => "#{setting.reward_percentage}"
             } == json_response(conn, 200)["data"]
    end
  end

  describe "update setting" do
    setup [:create_setting]

    test "renders setting when data is valid", %{conn: conn} do
      conn = patch(conn, ~p"/api/settings", setting: @update_attrs)

      assert %{
               "currency" => "JPY",
               "reward_percentage" => "20.00"
             } = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/settings")

      assert %{
               "currency" => "JPY",
               "reward_percentage" => "20.00"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      Enum.each(@invalid_attrs_list, fn invalid_attrs ->
        conn = patch(conn, ~p"/api/settings", setting: invalid_attrs)
        assert json_response(conn, 422)["errors"] != %{}
      end)
    end
  end

  defp create_setting(_) do
    setting = setting_fixture()
    %{setting: setting}
  end
end

defmodule RewardsWeb.SettingController do
  use RewardsWeb, :controller

  alias Rewards.Core
  alias Rewards.Core.Setting

  action_fallback RewardsWeb.FallbackController

  def show(conn, _) do
    setting = Core.get_setting!()
    render(conn, :show, setting: setting)
  end

  def update(conn, %{"setting" => setting_params}) do
    setting = Core.get_setting!()

    with {:ok, %Setting{} = setting} <- Core.update_setting(setting, setting_params) do
      render(conn, :show, setting: setting)
    end
  end
end

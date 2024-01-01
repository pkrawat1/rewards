defmodule RewardsWeb.SettingJSON do
  alias Rewards.Core.Setting

  @doc """
  Renders a list of settings.
  """
  def index(%{settings: settings}) do
    %{data: for(setting <- settings, do: data(setting))}
  end

  @doc """
  Renders a single setting.
  """
  def show(%{setting: setting}) do
    %{data: data(setting)}
  end

  defp data(%Setting{} = setting) do
    %{
      currency: setting.currency,
      reward_percentage: setting.reward_percentage
    }
  end
end

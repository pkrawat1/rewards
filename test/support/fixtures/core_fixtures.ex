defmodule Rewards.CoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rewards.Core` context.
  """

  @doc """
  Generate a setting.
  """
  def setting_fixture(attrs \\ %{}) do
    {:ok, setting} =
      attrs
      |> Enum.into(%{
        currency: "JPY",
        reward_percentage: "2"
      })
      |> Rewards.Core.create_setting()

    setting
  end
end

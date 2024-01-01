defmodule Rewards.RewardFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rewards.Reward` context.
  """

  @doc """
  Generate a points_history.
  """
  def points_history_fixture(attrs \\ %{}) do
    {:ok, points_history} =
      attrs
      |> Enum.into(%{
        points: "120.5",
        transaction_type: :earned
      })
      |> Rewards.Reward.create_points_history()

    points_history
  end
end

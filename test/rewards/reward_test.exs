defmodule Rewards.RewardTest do
  use Rewards.DataCase

  alias Rewards.Reward

  describe "points_history" do
    alias Rewards.Reward.PointsHistory

    import Rewards.RewardFixtures

    @invalid_attrs %{transaction_type: nil, points: nil}

    test "list_points_history/0 returns all points_history" do
      points_history = points_history_fixture()
      assert Reward.list_points_history() == [points_history]
    end

    test "get_points_history!/1 returns the points_history with given id" do
      points_history = points_history_fixture()
      assert Reward.get_points_history!(points_history.id) == points_history
    end

    test "create_points_history/1 with valid data creates a points_history" do
      valid_attrs = %{transaction_type: :earned, points: "120.5"}

      assert {:ok, %PointsHistory{} = points_history} = Reward.create_points_history(valid_attrs)
      assert points_history.transaction_type == :earned
      assert points_history.points == Decimal.new("120.5")
    end

    test "create_points_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reward.create_points_history(@invalid_attrs)
    end

    test "update_points_history/2 with valid data updates the points_history" do
      points_history = points_history_fixture()
      update_attrs = %{transaction_type: :spent, points: "456.7"}

      assert {:ok, %PointsHistory{} = points_history} = Reward.update_points_history(points_history, update_attrs)
      assert points_history.transaction_type == :spent
      assert points_history.points == Decimal.new("456.7")
    end

    test "update_points_history/2 with invalid data returns error changeset" do
      points_history = points_history_fixture()
      assert {:error, %Ecto.Changeset{}} = Reward.update_points_history(points_history, @invalid_attrs)
      assert points_history == Reward.get_points_history!(points_history.id)
    end

    test "delete_points_history/1 deletes the points_history" do
      points_history = points_history_fixture()
      assert {:ok, %PointsHistory{}} = Reward.delete_points_history(points_history)
      assert_raise Ecto.NoResultsError, fn -> Reward.get_points_history!(points_history.id) end
    end

    test "change_points_history/1 returns a points_history changeset" do
      points_history = points_history_fixture()
      assert %Ecto.Changeset{} = Reward.change_points_history(points_history)
    end
  end
end

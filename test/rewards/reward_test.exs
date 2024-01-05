defmodule Rewards.RewardTest do
  use Rewards.DataCase

  alias Rewards.Reward

  describe "points_history" do
    alias Rewards.Reward.PointsHistory

    import Rewards.{AccountFixtures}

    @invalid_attrs %{transaction_type: nil, points: nil}

    test "create_points_history/1 with valid data creates a points_history" do
      customer = customer_fixture()
      valid_attrs = %{transaction_type: :earned, points: "120.5", customer_id: customer.id}

      assert {:ok, %PointsHistory{} = points_history} = Reward.create_points_history(valid_attrs)
      assert points_history.transaction_type == :earned
      assert points_history.points == Decimal.new("120.5")
    end

    test "create_points_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reward.create_points_history(@invalid_attrs)
    end
  end
end

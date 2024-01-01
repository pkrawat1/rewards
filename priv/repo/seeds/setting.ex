defmodule Rewards.Seeds.Setting do
  import Rewards.Seeds.Base
  alias Rewards.Repo
  alias Rewards.Core.Setting

  def seed!() do
    %Setting{}
    |> Setting.changeset(%{
      reward_percentage: Decimal.new("1.00"),
      currency: "JPY"
    })
    |> Repo.insert()
    |> log_error("Setting")
  end
end

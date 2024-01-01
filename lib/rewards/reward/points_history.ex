defmodule Rewards.Reward.PointsHistory do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "points_history" do
    field :transaction_type, Ecto.Enum, values: [:earned, :spent]
    field :points, :decimal
    field :customer_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(points_history, attrs) do
    points_history
    |> cast(attrs, [:transaction_type, :points])
    |> validate_required([:transaction_type, :points])
  end
end

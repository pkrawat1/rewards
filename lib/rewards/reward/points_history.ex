defmodule Rewards.Reward.PointsHistory do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rewards.Reward

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "points_history" do
    field :transaction_type, Ecto.Enum, values: [:earned, :spent]
    field :points, :decimal
    field :balance, :decimal
    field :customer_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(points_history, attrs) do
    points_history
    |> cast(attrs, [:transaction_type, :points, :customer_id])
    |> validate_required([:transaction_type, :points, :customer_id])
    |> validate_number(:points, greater_than: 0)
    |> calculate_balance()
    |> validate_number(:balance, greater_than_or_equal_to: 0)
  end

  defp calculate_balance(
         %{
           changes: %{
             points: points,
             transaction_type: transaction_type,
             customer_id: customer_id
           }
         } = changeset
       )
       when not is_nil(points) and not is_nil(transaction_type) and not is_nil(customer_id) do
    prev_points_history = Reward.get_customer_latest_points_history(customer_id) || %{balance: 0}

    balance =
      case {prev_points_history, transaction_type} do
        {%{balance: balance}, :earned} -> Decimal.add(balance, points)
        {%{balance: balance}, :spent} -> Decimal.sub(balance, points)
      end

    change(changeset, balance: balance)
  end

  defp calculate_balance(changeset), do: changeset
end

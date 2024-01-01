defmodule Rewards.Core.Setting do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "settings" do
    field :currency, :string, default: "JPY"
    field :reward_percentage, :decimal, default: Decimal.new("1.0")

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(setting, attrs) do
    setting
    |> cast(attrs, [:reward_percentage, :currency])
    |> change(%{currency: String.upcase(attrs[:currency] || attrs["currency"] || "")})
    |> validate_required([:reward_percentage, :currency])
    |> validate_currency(:currency)
    |> validate_number(:reward_percentage,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    )
  end

  # Custom validation function for currency
  defp validate_currency(changeset, field) do
    validate_inclusion(changeset, field, Money.known_current_currencies())
  end
end

defmodule Rewards.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :currency, :string, default: "JPY"
    field :paid, :decimal
    field :customer_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:id, :paid, :currency])
    |> change(%{currency: String.upcase(attrs[:currency] || attrs["currency"] || "")})
    |> validate_required([:paid, :currency])
    |> validate_number(:paid, greater_than: 0)
    |> validate_currency(:currency)
    |> unique_constraint(:id, name: :orders_pkey)
  end

  # Custom validation function for currency
  defp validate_currency(changeset, field) do
    validate_inclusion(changeset, field, Money.known_current_currencies())
  end
end

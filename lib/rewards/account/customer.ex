defmodule Rewards.Account.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customers" do
    field :email, :string
    field :phone, :string

    field(:identifier, :string, virtual: true)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:email, :phone])
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> validate_required_contact_info()
    |> unique_constraint(:email)
    |> unique_constraint(:phone)
  end

  defp validate_required_contact_info(changeset) do
    if !is_email_or_phone_present(changeset) do
      changeset
      |> add_error(:email, "Email or phone number must be present")
      |> add_error(:phone, "Email or phone number must be present")
    else
      changeset
    end
  end

  defp is_email_or_phone_present(changeset) do
    email = get_field(changeset, :email)
    phone = get_field(changeset, :phone)

    !is_nil(email) || !is_nil(phone)
  end
end

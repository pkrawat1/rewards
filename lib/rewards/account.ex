defmodule Rewards.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias Rewards.Repo

  alias Rewards.Account.Customer

  @doc """
  Gets a single customer.

  ## Examples

      iex> get_customer_by_identifier("xyx@abc.xyz")
      %Customer{}

      iex> get_customer_by_identifier("+123214243")
      nil

  """
  def get_customer_by_identifier(identifier),
    do:
      Customer
      |> where([c], ilike(c.email, ^identifier))
      |> or_where([c], c.phone == ^Rewards.Utils.sanitize_phone_number(identifier))
      |> Repo.one()

  def get_customer_identifier(%{email: email, phone: phone}), do: email || phone

  def find_or_create_customer_changeset(attrs) do
    case get_customer_by_identifier(attrs["email"] || attrs["phone"] || "") do
      nil -> Customer.changeset(%Customer{}, attrs)
      customer -> change_customer(customer, attrs)
    end
  end

  @doc """
  Creates a customer.

  ## Examples

      iex> create_customer(%{field: value})
      {:ok, %Customer{}}

      iex> create_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a customer.

  ## Examples

      iex> update_customer(customer, %{field: new_value})
      {:ok, %Customer{}}

      iex> update_customer(customer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer(%Customer{} = customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer changes.

  ## Examples

      iex> change_customer(customer)
      %Ecto.Changeset{data: %Customer{}}

  """
  def change_customer(%Customer{} = customer, attrs \\ %{}) do
    Customer.changeset(customer, attrs)
  end
end

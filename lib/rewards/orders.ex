defmodule Rewards.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias Rewards.Repo

  alias Rewards.Orders.Order
  alias Rewards.Account
  alias Rewards.Account.Customer

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs["order"])
    |> find_or_create_customer(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

  defp find_or_create_customer(changeset, %{"customer" => customer_attrs}) do
    case Account.find_or_create_customer(customer_attrs) do
      {:error, _} ->
        changeset
        |> Ecto.Changeset.add_error(:customer_id, "Customer not found")

      {:ok, %Customer{id: customer_id}} ->
        changeset
        |> Ecto.Changeset.put_change(:customer_id, customer_id)
    end
  end

  defp find_or_create_customer(changeset, _), do: changeset
end

defmodule Rewards.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi

  alias Rewards.{Account, Repo, Reward}
  alias Rewards.Orders.Order
  alias Reward.PointsHistory

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
    Repo.transaction(fn ->
      Multi.new()
      |> Multi.insert_or_update(
        :customer,
        Account.find_or_create_customer(attrs["customer"] || %{})
      )
      |> Multi.insert(:order, fn %{customer: customer} ->
        Order.changeset(
          %Order{customer_id: customer.id},
          attrs["order"]
        )
      end)
      |> Multi.run(:reward_points, fn _repo, %{order: order} ->
        Reward.calculate_points(order.paid, order.currency)
      end)
      |> Multi.insert(:points_history, fn %{customer: customer, reward_points: reward_points} ->
        PointsHistory.changeset(
          %PointsHistory{},
          %{
            customer_id: customer.id,
            points: reward_points,
            transaction_type: :earned
          }
        )
      end)
      |> Repo.transaction()
    end)
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
end

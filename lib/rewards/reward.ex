defmodule Rewards.Reward do
  @moduledoc """
  The Reward context.
  """

  import Ecto.Query, warn: false
  alias Rewards.Repo

  alias Rewards.Reward.PointsHistory
  alias Rewards.Core

  @doc """
  Gets a customer lastest points_history.
  ## Examples

      iex> get_customer_latest_points_history(123)
      %PointsHistory{}

      iex> get_customer_latest_points_history(456)
      nil

  """
  def get_customer_latest_points_history(customer_id),
    do:
      PointsHistory
      |> where([p], p.customer_id == ^customer_id)
      |> order_by([c], desc: :inserted_at)
      |> limit(1)
      |> Repo.one()

  @doc """
  Creates a points_history.

  ## Examples

      iex> create_points_history(%{field: value})
      {:ok, %PointsHistory{}}

      iex> create_points_history(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_points_history(attrs \\ %{}) do
    %PointsHistory{}
    |> PointsHistory.changeset(attrs)
    |> Repo.insert()
  end

  def calculate_points(amount, _currency) do
    try do
      {:ok,
       Core.get_setting!()
       |> Map.get(:reward_percentage)
       |> Decimal.div(100)
       |> Decimal.mult(amount)}
    rescue
      _ ->
        {:error, :failed_points_calculation}
    end
  end
end

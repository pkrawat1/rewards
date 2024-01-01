defmodule Rewards.Reward do
  @moduledoc """
  The Reward context.
  """

  import Ecto.Query, warn: false
  alias Rewards.Repo

  alias Rewards.Reward.PointsHistory

  @doc """
  Returns the list of points_history.

  ## Examples

      iex> list_points_history()
      [%PointsHistory{}, ...]

  """
  def list_points_history do
    Repo.all(PointsHistory)
  end

  @doc """
  Gets a single points_history.

  Raises `Ecto.NoResultsError` if the Points history does not exist.

  ## Examples

      iex> get_points_history!(123)
      %PointsHistory{}

      iex> get_points_history!(456)
      ** (Ecto.NoResultsError)

  """
  def get_points_history!(id), do: Repo.get!(PointsHistory, id)

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

  @doc """
  Updates a points_history.

  ## Examples

      iex> update_points_history(points_history, %{field: new_value})
      {:ok, %PointsHistory{}}

      iex> update_points_history(points_history, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_points_history(%PointsHistory{} = points_history, attrs) do
    points_history
    |> PointsHistory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a points_history.

  ## Examples

      iex> delete_points_history(points_history)
      {:ok, %PointsHistory{}}

      iex> delete_points_history(points_history)
      {:error, %Ecto.Changeset{}}

  """
  def delete_points_history(%PointsHistory{} = points_history) do
    Repo.delete(points_history)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking points_history changes.

  ## Examples

      iex> change_points_history(points_history)
      %Ecto.Changeset{data: %PointsHistory{}}

  """
  def change_points_history(%PointsHistory{} = points_history, attrs \\ %{}) do
    PointsHistory.changeset(points_history, attrs)
  end
end

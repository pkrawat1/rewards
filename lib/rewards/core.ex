defmodule Rewards.Core do
  @moduledoc """
  The Core context.
  """

  import Ecto.Query, warn: false
  alias Rewards.Repo

  alias Rewards.Core.Setting

  @doc """
  Gets the setting.

  Raises `Ecto.NoResultsError` if the Setting does not exist.

  ## Examples

      iex> get_setting!()
      %Setting{}

      iex> get_setting!()
      ** (Ecto.NoResultsError)

  """
  def get_setting!(), do: Setting |> order_by([s], desc: s.inserted_at) |> limit(1) |> Repo.one()

  @doc """
  Creates a setting.

  ## Examples

      iex> create_setting(%{field: value})
      {:ok, %Setting{}}

      iex> create_setting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_setting(attrs \\ %{}) do
    %Setting{}
    |> Setting.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a setting.

  ## Examples

      iex> update_setting(setting, %{field: new_value})
      {:ok, %Setting{}}

      iex> update_setting(setting, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_setting(%Setting{} = setting, attrs) do
    setting
    |> Setting.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking setting changes.

  ## Examples

      iex> change_setting(setting)
      %Ecto.Changeset{data: %Setting{}}

  """
  def change_setting(%Setting{} = setting, attrs \\ %{}) do
    Setting.changeset(setting, attrs)
  end
end

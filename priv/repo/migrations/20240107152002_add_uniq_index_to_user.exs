defmodule Rewards.Repo.Migrations.AddUniqIndexToUser do
  use Ecto.Migration

  def change do
    create unique_index(:customers, [:email])
    create unique_index(:customers, [:phone])
  end
end

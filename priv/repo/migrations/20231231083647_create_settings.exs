defmodule Rewards.Repo.Migrations.CreateSettings do
  use Ecto.Migration

  def change do
    create table(:settings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :reward_percentage, :decimal
      add :currency, :string

      timestamps(type: :utc_datetime)
    end
  end
end

defmodule Rewards.Repo.Migrations.CreatePointsHistory do
  use Ecto.Migration

  def change do
    create table(:points_history, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :transaction_type, :string
      add :points, :decimal
      add :customer_id, references(:customers, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:points_history, [:customer_id])
  end
end

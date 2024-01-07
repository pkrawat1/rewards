defmodule Rewards.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :paid, :decimal
      add :currency, :string
      add :customer_id, references(:customers, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:orders, [:customer_id])
  end
end

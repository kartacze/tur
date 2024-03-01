defmodule Tur.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :amount, :decimal, precision: 15, scale: 6, null: false
      add :currency, :string
      add :transfer_date, :date
      add :debitor_id, references(:wallets, on_delete: :nothing), null: false
      add :creditor_id, references(:wallets, on_delete: :nothing), null: false
      add :description, :string

      timestamps(type: :utc_datetime)
    end

    create index(:transfers, [:debitor_id])
    create index(:transfers, [:creditor_id])
  end
end

defmodule Tur.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :name, :string, null: false
      add :currency, :string, null: false
      add :quantity, :decimal, precision: 15, scale: 6, null: false

      timestamps(type: :utc_datetime)
    end
  end
end

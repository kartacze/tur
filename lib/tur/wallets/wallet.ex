defmodule Tur.Wallets.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :name, :string
    field :currency, :string
    field :quantity, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:name, :currency, :quantity])
    |> validate_required([:name, :currency, :quantity])
  end
end

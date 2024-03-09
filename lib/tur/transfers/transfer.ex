defmodule Tur.Transfers.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transfers" do
    field :currency, :string
    field :description, :string
    field :amount, :decimal
    field :transfer_date, :date

    belongs_to :debitor, Tur.Wallets.Wallet, on_replace: :nilify
    belongs_to :creditor, Tur.Wallets.Wallet, on_replace: :nilify

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transfer, attrs) do
    transfer
    |> cast(attrs, [:amount, :currency, :transfer_date])
    |> validate_required([:amount, :currency, :transfer_date])
  end
end

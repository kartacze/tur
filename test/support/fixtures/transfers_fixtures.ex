defmodule Tur.TransfersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tur.Transfers` context.
  """

  import Tur.WalletsFixtures

  @doc """
  Generate a transfer.
  """
  def transfer_fixture(attrs \\ %{}) do
    wallet_debitor = wallet_fixture(%{name: "wallet 1"})
    wallet_creditor = wallet_fixture(%{name: "wallet 2"})

    {:ok, transfer} =
      attrs
      |> Enum.into(%{
        "amount" => "120.5",
        "currency" => "PLN",
        "transfer_date" => "2024-02-28",
        "debitor" => %{"id" => wallet_debitor.id},
        "creditor" => %{"id" => wallet_creditor.id}
      })
      |> Tur.Transfers.create_transfer()

    transfer
  end
end

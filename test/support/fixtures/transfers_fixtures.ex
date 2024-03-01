defmodule Tur.TransfersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tur.Transfers` context.
  """

  @doc """
  Generate a transfer.
  """
  def transfer_fixture(attrs \\ %{}) do
    {:ok, transfer} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        currency: "some currency",
        transfer_date: ~U[2024-02-28 14:18:00Z]
      })
      |> Tur.Transfers.create_transfer()

    transfer
  end
end

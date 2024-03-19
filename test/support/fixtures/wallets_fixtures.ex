defmodule Tur.WalletsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tur.Wallets` context.
  """

  @doc """
  Generate a wallet.
  """
  def wallet_fixture(attrs \\ %{}) do
    {:ok, wallet} =
      attrs
      |> Enum.into(%{
        currency: "some currency",
        name: "some name",
        quantity: "0"
      })
      |> Tur.Wallets.create_wallet()

    wallet
  end
end

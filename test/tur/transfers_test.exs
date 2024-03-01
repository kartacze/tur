defmodule Tur.TransfersTest do
  use Tur.DataCase

  alias Tur.Transfers

  describe "transfers" do
    alias Tur.Transfers.Transfer

    import Tur.TransfersFixtures

    @invalid_attrs %{currency: nil, amount: nil, transfer_date: nil}

    test "list_transfers/0 returns all transfers" do
      transfer = transfer_fixture()
      assert Transfers.list_transfers() == [transfer]
    end

    test "get_transfer!/1 returns the transfer with given id" do
      transfer = transfer_fixture()
      assert Transfers.get_transfer!(transfer.id) == transfer
    end

    test "create_transfer/1 with valid data creates a transfer" do
      valid_attrs = %{currency: "some currency", amount: "120.5", transfer_date: ~U[2024-02-28 14:18:00Z]}

      assert {:ok, %Transfer{} = transfer} = Transfers.create_transfer(valid_attrs)
      assert transfer.currency == "some currency"
      assert transfer.amount == Decimal.new("120.5")
      assert transfer.transfer_date == ~U[2024-02-28 14:18:00Z]
    end

    test "create_transfer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transfers.create_transfer(@invalid_attrs)
    end

    test "update_transfer/2 with valid data updates the transfer" do
      transfer = transfer_fixture()
      update_attrs = %{currency: "some updated currency", amount: "456.7", transfer_date: ~U[2024-02-29 14:18:00Z]}

      assert {:ok, %Transfer{} = transfer} = Transfers.update_transfer(transfer, update_attrs)
      assert transfer.currency == "some updated currency"
      assert transfer.amount == Decimal.new("456.7")
      assert transfer.transfer_date == ~U[2024-02-29 14:18:00Z]
    end

    test "update_transfer/2 with invalid data returns error changeset" do
      transfer = transfer_fixture()
      assert {:error, %Ecto.Changeset{}} = Transfers.update_transfer(transfer, @invalid_attrs)
      assert transfer == Transfers.get_transfer!(transfer.id)
    end

    test "delete_transfer/1 deletes the transfer" do
      transfer = transfer_fixture()
      assert {:ok, %Transfer{}} = Transfers.delete_transfer(transfer)
      assert_raise Ecto.NoResultsError, fn -> Transfers.get_transfer!(transfer.id) end
    end

    test "change_transfer/1 returns a transfer changeset" do
      transfer = transfer_fixture()
      assert %Ecto.Changeset{} = Transfers.change_transfer(transfer)
    end
  end
end

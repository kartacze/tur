defmodule Tur.TransfersTest do
  use Tur.DataCase

  alias Tur.Transfers

  describe "transfers" do
    alias Tur.Transfers.Transfer

    import Tur.TransfersFixtures
    import Tur.WalletsFixtures

    test "list_transfers/0 returns all transfers" do
      transfer = transfer_fixture()
      assert Transfers.list_transfers() == [transfer]
    end

    test "get_transfer!/1 returns the transfer with given id" do
      transfer = transfer_fixture()
      assert Transfers.get_transfer!(transfer.id) == transfer
    end

    test "create_transfer/1 with valid data creates a transfer" do
      wallet_1 = wallet_fixture(%{name: "wallet 1"})
      wallet_2 = wallet_fixture(%{name: "wallet 2"})

      valid_attrs = %{
        "currency" => "PLN",
        "amount" => "120.5",
        "transfer_date" => "2024-02-27",
        "debitor" => %{"id" => wallet_1.id},
        "creditor" => %{"id" => wallet_2.id}
      }

      assert {:ok, %Transfer{} = transfer} = Transfers.create_transfer(valid_attrs)
      assert transfer.currency == "PLN"
      assert transfer.amount == Decimal.new("120.5")
      assert transfer.transfer_date == ~D[2024-02-27]
    end

    # test "create_transfer/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Transfers.create_transfer(@invalid_attrs)
    # end

    test "update_transfer/2 with valid data updates the transfer" do
      transfer = transfer_fixture()
      %{id: debitor_id} = wallet_fixture(%{name: "new debitor"})
      %{id: creditor_id} = wallet_fixture(%{name: "new creditor"})

      update_attrs = %{
        "currency" => "EUR",
        "amount" => "456.7",
        "transfer_date" => "2024-02-29",
        "debitor" => %{"id" => debitor_id},
        "creditor" => %{"id" => creditor_id}
      }

      assert {:ok, %Transfer{} = transfer} = Transfers.update_transfer(transfer, update_attrs)

      assert transfer.currency == "EUR"
      assert transfer.amount == Decimal.new("456.7")
      assert transfer.transfer_date == ~D[2024-02-29]
      assert transfer.debitor.id == debitor_id
      assert transfer.creditor.id == creditor_id
    end

    # test "update_transfer/2 with invalid data returns error changeset" do
    #   invalid_attrs = %{
    #     "currency" => nil,
    #     "amount" => nil,
    #     "transfer_date" => nil,
    #     "creditor" => %{id: 100},
    #     "debitor" => %{id: 1001}
    #   }
    #
    #   transfer = transfer_fixture()
    #   assert {:error} = Transfers.update_transfer(transfer, invalid_attrs)
    #   assert transfer == Transfers.get_transfer!(transfer.id)
    # end

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

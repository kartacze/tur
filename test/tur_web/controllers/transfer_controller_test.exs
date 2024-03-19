defmodule TurWeb.TransferControllerTest do
  use TurWeb.ConnCase

  import Tur.TransfersFixtures
  import Tur.WalletsFixtures

  @invalid_attrs %{
    "currency" => nil,
    "amount" => nil,
    "transfer_date" => nil
  }

  describe "index" do
    test "lists all transfers", %{conn: conn} do
      conn = get(conn, ~p"/transfers")
      assert html_response(conn, 200) =~ "Listing Transfers"
    end
  end

  describe "new transfer" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/transfers/new")
      assert html_response(conn, 200) =~ "New Transfer"
    end
  end

  describe "create transfer" do
    test "redirects to show when data is valid", %{conn: conn} do
      creditor = wallet_fixture(%{name: "creditor"})
      debitor = wallet_fixture(%{name: "debitor"})

      create_attrs = %{
        "currency" => "some currency",
        "amount" => "120.5",
        "transfer_date" => "2024-02-28",
        "creditor" => %{"id" => creditor.id},
        "debitor" => %{"id" => debitor.id}
      }

      conn = post(conn, ~p"/transfers", transfer: create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/transfers/#{id}"

      conn = get(conn, ~p"/transfers/#{id}")
      assert html_response(conn, 200) =~ "Transfer #{id}"
    end

    # test "renders errors when data is invalid", %{conn: conn} do
    #   conn = post(conn, ~p"/transfers", transfer: @invalid_attrs)
    #   assert html_response(conn, 200) =~ "New Transfer"
    # end
  end

  describe "edit transfer" do
    setup [:create_transfer]

    test "renders form for editing chosen transfer", %{conn: conn, transfer: transfer} do
      conn = get(conn, ~p"/transfers/#{transfer}/edit")
      assert html_response(conn, 200) =~ "Edit Transfer"
    end
  end

  describe "update transfer" do
    setup [:create_transfer]

    test "redirects when data is valid", %{conn: conn, transfer: transfer} do
      update_attrs = %{
        "currency" => "some updated currency",
        "amount" => "456.7",
        "transfer_date" => "2024-02-29"
      }

      conn = put(conn, ~p"/transfers/#{transfer}", transfer: update_attrs)
      assert redirected_to(conn) == ~p"/transfers/#{transfer}"

      conn = get(conn, ~p"/transfers/#{transfer}")
      assert html_response(conn, 200) =~ "some updated currency"
    end

    test "renders errors when data is invalid", %{conn: conn, transfer: transfer} do
      conn = put(conn, ~p"/transfers/#{transfer}", transfer: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Transfer"
    end
  end

  describe "delete transfer" do
    setup [:create_transfer]

    test "deletes chosen transfer", %{conn: conn, transfer: transfer} do
      conn = delete(conn, ~p"/transfers/#{transfer}")
      assert redirected_to(conn) == ~p"/transfers"

      assert_error_sent 404, fn ->
        get(conn, ~p"/transfers/#{transfer}")
      end
    end
  end

  defp create_transfer(_) do
    transfer = transfer_fixture()
    %{transfer: transfer}
  end
end

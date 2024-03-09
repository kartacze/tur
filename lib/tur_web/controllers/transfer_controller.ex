defmodule TurWeb.TransferController do
  use TurWeb, :controller

  alias Tur.Transfers
  alias Tur.Transfers.Transfer

  def index(conn, _params) do
    transfers = Transfers.list_transfers()
    render(conn, :index, transfers: transfers)
  end

  def new(conn, _params) do
    changeset = Transfers.change_transfer(%Transfer{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"transfer" => transfer_params}) do
    case Transfers.create_transfer(transfer_params) do
      {:ok, transfer} ->
        conn
        |> put_flash(:info, "Transfer created successfully.")
        |> redirect(to: ~p"/transfers/#{transfer}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    transfer = Transfers.get_transfer!(id)
    render(conn, :show, transfer: transfer)
  end

  def edit(conn, %{"id" => id}) do
    transfer = Transfers.get_transfer!(id)
    changeset = Transfers.change_transfer(transfer)
    render(conn, :edit, transfer: transfer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transfer" => transfer_params}) do
    transfer = Transfers.get_transfer!(id)

    IO.inspect(transfer_params)

    case Transfers.update_transfer(transfer, transfer_params) do
      {:ok, transfer} ->
        conn
        |> put_flash(:info, "Transfer updated successfully.")
        |> redirect(to: ~p"/transfers/#{transfer}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, transfer: transfer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transfer = Transfers.get_transfer!(id)
    {:ok, _transfer} = Transfers.delete_transfer(transfer)

    conn
    |> put_flash(:info, "Transfer deleted successfully.")
    |> redirect(to: ~p"/transfers")
  end
end

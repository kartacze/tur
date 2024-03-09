defmodule Tur.Transfers do
  @moduledoc """
  The Transfers context.
  """

  import Ecto.Query, warn: false
  alias Tur.Wallets
  alias Tur.Wallets.Wallet
  alias Tur.Repo

  alias Tur.Transfers.Transfer

  @doc """
  Returns the list of transfers.

  ## Examples

      iex> list_transfers()
      [%Transfer{}, ...]

  """
  def list_transfers do
    Transfer |> Repo.all() |> Repo.preload(:debitor) |> Repo.preload(:creditor)
  end

  @doc """
  Gets a single transfer.

  Raises `Ecto.NoResultsError` if the Transfer does not exist.

  ## Examples

      iex> get_transfer!(123)
      %Transfer{}

      iex> get_transfer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transfer!(id) do
    Transfer |> Repo.get!(id) |> Repo.preload(:creditor) |> Repo.preload(:debitor)
  end

  @doc """
  Creates a transfer.

  ## Examples

      iex> create_transfer(%{field: value})
      {:ok, %Transfer{}}

      iex> create_transfer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transfer(%{
        creditor: creditor,
        debitor: debitor,
        amount: amount,
        transfer_date: transfer_date,
        currency: currency
      }) do
    debitor = Wallets.get_wallet!(debitor.id)
    creditor = Wallets.get_wallet!(creditor.id)

    {:ok, date} = Date.from_iso8601(transfer_date)

    resp =
      %Transfer{
        amount: Decimal.new(amount),
        currency: currency,
        transfer_date: date
      }
      |> Transfer.changeset(%{})
      |> Ecto.Changeset.put_assoc(:creditor, creditor)
      |> Ecto.Changeset.put_assoc(:debitor, debitor)
      |> Repo.insert()

    resp
  end

  @doc """
  Updates a transfer.

  ## Examples

      iex> update_transfer(transfer, %{field: new_value})
      {:ok, %Transfer{}}

      iex> update_transfer(transfer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transfer(%Transfer{} = transfer, attrs) do
    IO.inspect(attrs)

    transfer
    |> Transfer.changeset(attrs)
    |> update_debitor(attrs)
    |> update_creditor(attrs)
    |> Repo.update()
  end

  defp update_debitor(changeset, %{"debitor" => %{"id" => id}}) do
    IO.inspect("UPDATE DEBITOR")
    debitor = Wallets.get_wallet!(id)

    changeset
    |> Ecto.Changeset.put_assoc(:debitor, debitor)
  end

  defp update_debitor(changeset, _attrs) do
    changeset
  end

  defp update_creditor(changeset, %{"creditor" => %{"id" => id}}) do
    IO.inspect("UPDATE CREDITOR")
    creditor = Wallets.get_wallet!(id)

    changeset
    |> Ecto.Changeset.put_assoc(:creditor, creditor)
  end

  defp update_creditor(changeset, _attrs) do
    changeset
  end

  @doc """
  Deletes a transfer.

  ## Examples

      iex> delete_transfer(transfer)
      {:ok, %Transfer{}}

      iex> delete_transfer(transfer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transfer(%Transfer{} = transfer) do
    Repo.delete(transfer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transfer changes.

  ## Examples

      iex> change_transfer(transfer)
      %Ecto.Changeset{data: %Transfer{}}

  """
  def change_transfer(%Transfer{} = transfer, attrs \\ %{}) do
    Transfer.changeset(transfer, attrs)
  end
end

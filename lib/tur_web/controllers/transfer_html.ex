defmodule TurWeb.TransferHTML do
  use TurWeb, :html

  embed_templates "transfer_html/*"

  @doc """
  Renders a transfer form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true


  def transfer_form(assigns)

  def debitor_opts(changeset) do
    debitor_id =
      changeset
      |> Ecto.Changeset.get_change(:debitor_id, [])
      |> Enum.map(& &1.data.wallet_id)

    wallets =
      Tur.Wallets.list_wallets() 

    for wallet <- wallets,
        do: [key: wallet.name, value: wallet.id, selected: debitor_id == wallet.id]
  end

  def creditor_opts(changeset) do
    creditor_id =
      changeset
      |> Ecto.Changeset.get_change(:creditor_id, [])
      |> Enum.map(& &1.data.wallet_id)

    wallets =
      Tur.Wallets.list_wallets() 

    for wallet <- wallets,
        do: [key: wallet.name, value: wallet.id, selected: creditor_id == wallet.id]
  end
end

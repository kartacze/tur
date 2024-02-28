defmodule TurWeb.WalletHTML do
  use TurWeb, :html

  embed_templates "wallet_html/*"

  @doc """
  Renders a wallet form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def wallet_form(assigns)
end

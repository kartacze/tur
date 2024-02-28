defmodule Tur.Repo do
  use Ecto.Repo,
    otp_app: :tur,
    adapter: Ecto.Adapters.SQLite3
end

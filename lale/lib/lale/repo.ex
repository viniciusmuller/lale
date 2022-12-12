defmodule Lale.Repo do
  use Ecto.Repo,
    otp_app: :lale,
    adapter: Ecto.Adapters.Postgres
end

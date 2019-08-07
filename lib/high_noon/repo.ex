defmodule HighNoon.Repo do
  use Ecto.Repo,
    otp_app: :high_noon,
    adapter: Ecto.Adapters.Postgres
end

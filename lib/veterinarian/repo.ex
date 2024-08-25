defmodule Veterinarian.Repo do
  use Ecto.Repo,
    otp_app: :veterinarian,
    adapter: Ecto.Adapters.Postgres
end

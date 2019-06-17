defmodule MandarinOffice.Repo do
  use Ecto.Repo,
    otp_app: :mandarin_office,
    adapter: Ecto.Adapters.Postgres

  use Paginator
end

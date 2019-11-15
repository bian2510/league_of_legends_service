defmodule LeagueOfLegendsService.Repo do
  use Ecto.Repo,
    otp_app: :league_of_legends_service,
    adapter: Ecto.Adapters.Postgres
end

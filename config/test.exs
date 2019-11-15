use Mix.Config

# Configure your database
config :league_of_legends_service, LeagueOfLegendsService.Repo,
  username: "postgres",
  password: "postgres",
  database: "league_of_legends_service_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :league_of_legends_service, LeagueOfLegendsServiceWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

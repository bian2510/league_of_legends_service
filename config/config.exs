# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :league_of_legends_service,
  ecto_repos: [LeagueOfLegendsService.Repo]

# Configures the endpoint
config :league_of_legends_service, LeagueOfLegendsServiceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a6sMA1EBkWuD+VLc8tUxK97KV7PDq7OS0NQdSKVQtIM8xKTjr4vv646lZQxPrnPU",
  render_errors: [view: LeagueOfLegendsServiceWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LeagueOfLegendsService.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

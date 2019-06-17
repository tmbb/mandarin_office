# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mandarin_office,
  ecto_repos: [MandarinOffice.Repo]

# Configures the endpoint
config :mandarin_office, MandarinOfficeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pgdyVL/AV0pagfMqhBsLXKl7o6dhISGMb5q3GSqt7qmb4yD0XX/rl1Z2raUBzYaV",
  render_errors: [view: MandarinOfficeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MandarinOffice.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

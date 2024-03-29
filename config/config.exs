# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :high_noon,
  ecto_repos: [HighNoon.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :high_noon, HighNoonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cYcawWx3Jll4jLvAb03yTSm/UrhdkhdB27dLbhD6TojZnyBJmsYU/TCLHqm7zxQt",
  render_errors: [view: HighNoonWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: HighNoon.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :high_noon, HighNoonWeb.Guardian,
  issuer: "high_noon",
  secret_key: "HNFSXWeTPYsq9j+s6pDsbi0tUuOOfrmmkQUQogEIf3ZA468uh9MrlAQ+rTN+9Nmk"

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :jsonapi,
  field_transformation: :camelize

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

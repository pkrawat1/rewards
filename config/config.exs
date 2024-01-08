# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :rewards,
  ecto_repos: [Rewards.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :rewards, RewardsWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: RewardsWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Rewards.PubSub,
  live_view: [signing_salt: "UgNECvQu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :rewards, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: RewardsWeb.Router,
      endpoint: RewardsWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :points_api,
  ecto_repos: [PointsApi.Repo]

# Configures the endpoint
config :points_api, PointsApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PointsApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PointsApi.PubSub,
  live_view: [signing_salt: "/LOdaPb0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

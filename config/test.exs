import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :points_api, PointsApi.Repo,
  username: "points",
  password: "points",
  database: "points_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :points_api, PointsApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Zzqdpt9v61qDEtdA+dTN3lRNKgRjXulK7+DN2GVKoOFeHIsuKYhwCA5kWGgOhJRJ",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Mocks Worker GenServer
config :points_api, worker: PointsApi.WorkerMock

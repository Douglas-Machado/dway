import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :dway, Dway.Repo,
  username: "postgres",
  password: "postgres",
  database: "dway_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dway, DwayWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  server: false

# In test we don't send emails.
config :dway, Dway.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

config :dway,
  osrm_docker: "http://127.0.0.1:5000/route/v1/driving/",
  osrm: "http://router.project-osrm.org/route/v1/driving/"

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

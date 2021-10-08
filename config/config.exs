# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :dway,
  ecto_repos: [Dway.Repo]

config :dway, Dway.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :dway, DwayWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ut5ct5hUp2psXxFU0vMp2OEeMwjB9jq1t9w90dbFTe69D4iFQSS4DdSrZO5c0bli",
  render_errors: [view: DwayWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Dway.PubSub,
  live_view: [signing_salt: "e2SpCLKN"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :dway, Dway.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :dway,
  osrm_docker: "http://127.0.0.1:5000/route/v1/driving/",
  osrm: "http://router.project-osrm.org/route/v1/driving/"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

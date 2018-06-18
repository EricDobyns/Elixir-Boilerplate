# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :myapi,
  namespace: MyApi,
  ecto_repos: [MyApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :myapi, MyApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3wCrhd3a6Bm3T37roPrf6424hv6VrqxZKONeyH6ZqQkqonF+UMV24RY8pf7D8O0w",
  render_errors: [view: MyApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MyApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Guardian config
config :myapi, MyApi.Guardian,
  issuer: "myapi",
  ttl: { 30, :days },
  verify_issuer: true,
  secret_key: "R9gA3Uhy4Z643VwUDcCw9z9RL/JYlvMVa1aXR3y5sMC5UQh1deGhCGtsrowe4pTG"  

config :myapi, MyApp.Guardian.AuthPipeline,
  module: MyApp.Guardian,
  error_handler: MyApp.AuthErrorHandler               

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

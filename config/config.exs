# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :server,
  generators: [context_app: false]

# Configures the endpoint
config :server, Server.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: Server.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Server.PubSub,
  live_view: [signing_salt: "YL7syv0k"],
  host:     System.get_env("MONGODB_HOST")     || "172.17.0.3",
  user:     System.get_env("MONGODB_USER")     || "user",
  password: System.get_env("MONGODB_PASSWORD") || "12345",
  port:     System.get_env("MONGODB_PORT") || "27017",
  db:       System.get_env("MONGODB_NAME") || "workplayce"

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
#import_config "#{config_env()}.exs"

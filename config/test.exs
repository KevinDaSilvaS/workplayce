import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :server, Server.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RuBgSIjA46QrTVy3m9pIHRVk9RlM+4KEhILvtqpBxgNskNRTlcwqYVnDZmFbUUEP",
  server: false

import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :chat_party, ChatParty.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "chat_party_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chat_party, ChatPartyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "vyX+ln6AEqZiZ58/yTmpkXP0P4AO13AgtgqBcf4b8Q/ZgUE8TU3WVoNu728kP5TO",
  server: false

# In test we don't send emails.
config :chat_party, ChatParty.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

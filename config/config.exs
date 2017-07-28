# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :frequency,
  ecto_repos: [Frequency.Repo]

# Configures the endpoint
config :frequency, Frequency.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pIR0e5/N/jAgtiexjLlbarXzIopdb1G2WTEdlP/LuIOmdLKn0pZvOMMzUB5JKu7I",
  render_errors: [view: Frequency.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Frequency.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    google: { Ueberauth.Strategy.Google, [] },
    identity: { Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"],
      uid_field: :username,
      nickname_field: :username,
      param_nesting: "user"
    ]}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_FREQUENCY_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_FREQUENCY_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

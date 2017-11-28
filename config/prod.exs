use Mix.Config

config :frequency, FrequencyWeb.Endpoint,
  load_from_system_env: true,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "public-frequency.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

config :frequency, Frequency.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  database: "",
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :logger, level: :info

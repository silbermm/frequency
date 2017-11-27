use Mix.Config

config :frequency, FrequencyWeb.Endpoint,
  on_init: {FrequencyWeb.Endpoint, :load_from_system_env, []},
  url: [host: "example.com", port: 4000],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  secret_key_base: "${SECRET_KEY_BASE}"

config :frequency, Frequency.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "",
  pool_size: 1,
  ssl: true

config :logger, level: :info

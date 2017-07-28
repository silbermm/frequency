defmodule Frequency.Mixfile do
  use Mix.Project

  def project do
    [app: :frequency,
     version: "0.0.1",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  def application do
    [mod: {Frequency.Application, []},
     extra_applications: [:logger, :runtime_tools]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [{:phoenix, "~> 1.3.0-rc3", override: true},
     {:phoenix_pubsub, "~> 1.0", override: true},
     {:phoenix_ecto, "~> 3.2"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev, override: true},
     {:dogma, "~> 0.1", only: :dev},
     {:dialyxir, "~> 0.5.0", only: [:dev]},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:ueberauth, "~> 0.4"},
     {:ueberauth_google, "~> 0.5"},
     {:ueberauth_identity, "~> 0.2"},
     {:guardian, "~> 0.14", override: true},
     {:comeonin, "~> 3.0"}]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end

defmodule TicketAgent.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ticket_agent,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {TicketAgent.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:calendar, "~> 0.17.0"},
      {:coherence, "~> 0.1"},
      {:cloudinex, "~> 0.1"},
      {:ecto, "~> 2.1"},
      {:extwitter, "~> 0.8"},
      {:html_sanitize_ex, "~> 1.3.0-rc3"},
      {:oauth2, "~> 0.9"},
      {:poison, "~> 3.1"},
      {:postgrex, ">= 0.0.0"},
      {:swoosh, "~> 0.12.0"},
      {:gen_smtp, "~> 0.12.0"},
      {:qrcode, git: "https://gitlab.com/Pacodastre/qrcode", runtime: false},

      {:bypass, "~> 0.7", only: :test},
      {:credo, "~> 0.8", only: [:dev, :test]},
      {:ex_guard, "~> 1.2", only: :dev},
      {:ex_machina, "~> 2.0", only: :test},
      {:junit_formatter, "~> 1.1", only: :test},
      {:phoenix_live_reload, "~> 1.0", only: :dev},

    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end

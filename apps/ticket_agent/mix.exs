defmodule TicketAgent.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ticket_agent,
      version: append_revision("0.1.4"),
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def append_revision(version) do
    "#{version}+#{revision()}"
  end

  defp revision() do
    System.cmd("git", ["rev-parse", "--short", "HEAD"])
    |> elem(0)
    |> String.trim_trailing()
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {TicketAgent.Application, []},
      extra_applications: [:logger, :runtime_tools, :porcelain, :pdf_generator]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:puppeteer_pdf, "~> 1.0.0"},
      {:calendar, "~> 0.17.0"},
      {:coherence, "~> 0.1"},
      {:cloudinex, "~> 0.1"},
      {:ecto, "~> 2.1"},
      {:extwitter, "~> 0.8"},
      {:html_sanitize_ex, "~> 1.3.0-rc3"},
      {:oauth2, "~> 0.9.3"},
      {:postgrex, ">= 0.0.0"},
      {:swoosh, "~> 0.17.0"},
      {:gen_smtp, "~> 0.13.0"},
      # {:qrcode, git: "https://gitlab.com/Pacodastre/qrcode", runtime: false},
      {:qrcode, github: "sunboshan/qrcode"},
      {:pdf_generator, github: "PushComedyTheater/elixir-pdf-generator"},
      {:curtail, "~> 0.1"},
      {:icalendar, "~> 0.7.0"},
      {:paper_trail, "~> 0.8"},
      {:scrivener_ecto, "~> 1.0"},
      {:bypass, "~> 0.7", only: :test},
      {:credo, "~> 0.10", only: [:dev, :test]},
      {:ex_guard, "~> 1.2", only: :dev},
      {:ex_machina, "~> 2.0", only: :test},
      {:junit_formatter, "~> 2.2", only: :test},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:faker_elixir_octopus, "~> 1.0.0", only: [:dev, :test]},
      {:mox, "~> 0.3", only: :test},
      {:timber, "~> 2.0"}
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
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end

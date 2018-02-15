defmodule TicketAgent.Umbrella.Mixfile do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: append_revision("0.0.4"),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def append_revision(version) do
    "#{version}+#{revision()}"
  end

  defp revision() do
    System.cmd("git", ["rev-parse", "--short", "HEAD"])
    |> elem(0)
    |> String.trim_trailing
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps folder
  defp deps do
    [
      {:edeliver, "~> 1.4.5"},
      {:distillery, "~> 1.5", warn_missing: false},
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
      "ecto.setup": [
        "ecto.create",
        "ecto.migrate",
        "run apps/ticket_agent/priv/repo/seeds.exs",
        "ecto.dump"
        ],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.drop", "ecto.create --quiet", "ecto.load", "test"]
    ]
  end
end

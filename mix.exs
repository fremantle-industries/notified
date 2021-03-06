defmodule Notified.MixProject do
  use Mix.Project

  def project do
    [
      app: :notified,
      version: "0.0.6",
      elixir: "~> 1.10",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def application do
    [
      mod: {Notified.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:bamboo, "~> 2.1"},
      {:bamboo_smtp, "~> 4.0"},
      {:confex, "~> 3.5"},
      {:ecto, "~> 3.6"},
      {:ecto_sql, "~> 3.6"},
      {:etso, "~> 0.1.6"},
      {:phoenix_pubsub, "~> 2.0"},
      {:paged_query, "~> 0.0.2"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_unit_notifier, "~> 1.0", only: :test},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp description do
    "An Elixir library for application notifications"
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Alex Kwiatkowski"],
      links: %{"GitHub" => "https://github.com/fremantle-industries/notified"}
    }
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end

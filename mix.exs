defmodule KinoBenchee.MixProject do
  use Mix.Project

  @version "0.1.1"
  @description "Benchee integration with Livebook"

  def project do
    [
      app: :kino_benchee,
      version: @version,
      description: @description,
      name: "KinoBenchee",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:kino, "~> 0.12"},
      {:kino_vega_lite, "~> 0.1.0"},
      {:benchee, "~> 1.3"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "components",
      source_url: "https://github.com/livebook-dev/kino_benchee",
      source_ref: "v#{@version}",
      extras: ["guides/components.livemd"]
    ]
  end

  def package do
    [
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/livebook-dev/kino_benchee"
      }
    ]
  end
end

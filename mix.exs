defmodule KinoBenchee.MixProject do
  use Mix.Project

  def project do
    [
      app: :kino_benchee,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:kino, "~> 0.6.2"},
      {:kino_vega_lite, "~> 0.1.3"},
      {:benchee, "~> 1.1.0"}
    ]
  end
end

defmodule QuickcheckPlayground.Mixfile do
  use Mix.Project

  def project do
    [app: :quickcheck_playground,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_pattern: "*_{test,eqc}.exs",
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:eqc_ex, "~> 1.4.2"}]
  end
end

defmodule Ordnunger.MixProject do
  use Mix.Project

  def project do
    [app: :ordnunger,
     version: "0.1.0",
     elixir: "~> 1.6-dev",
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [mod: {Ordnunger.App, []},
     applications: [:trot],
     extra_applications: [:logger]]
  end

  defp deps do
    [{:trot, github: "hexedpackets/trot"},
     {:distillery, "~> 1.5", runtime: false}]
    # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
  end
end

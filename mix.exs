defmodule Treex.MixProject do
  use Mix.Project

  def project do
    [
      app: :treex,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "Treex",
      source_url: "https://github.com/ignaci0/treex"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp description() do
    """
    An Elixir wrapper to the Erlang's :gb_trees module.

    It also provides stream/1 on top
    """
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ignaci0/treex"}
    ]
  end
end

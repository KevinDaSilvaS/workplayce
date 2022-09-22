defmodule Src.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      version: "0.0.1",
      elixir: "~> 1.14",
      releases: [
        src: [
          applications: [
            auth: :permanent,
            availability: :permanent,
            bookings: :permanent,
            companies: :permanent,
            places: :permanent,
            users: :permanent,
            server: :permanent
          ]
        ]
      ]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    []
  end
end

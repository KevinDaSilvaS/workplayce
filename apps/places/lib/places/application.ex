defmodule Places.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  ## {:ok, conn} = Mongo.start_link(url: "mongodb://172.17.0.3:27017/notifications", username: "user", password: "12345")
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Mongo,
       [url: "mongodb://172.17.0.3:27017/admin",
       username: "user",
       password: "12345",
       auth_source: "admin",
       auth_mecanism: "SCRAM-SHA-1",
       name: Mongo.Places]}
      # Starts a worker by calling: Places.Worker.start_link(arg)
      # {Places.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Places.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

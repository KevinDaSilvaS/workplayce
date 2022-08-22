defmodule Availability.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @config Application.fetch_env!(:server, Server.Endpoint)
  @username Keyword.get(@config, :user)
  @password Keyword.get(@config, :password)
  @host Keyword.get(@config, :host)
  @port Keyword.get(@config, :port)
  @db Keyword.get(@config, :db)

  @impl true
  def start(_type, _args) do
    children = [
      {Mongo,
       [
         url: "mongodb://#{@host}:#{@port}/#{@db}",
         username: @username,
         password: @password,
         auth_source: "admin",
         auth_mecanism: "SCRAM-SHA-1",
         name: Mongo.Availability
       ]}
      # Starts a worker by calling: Availability.Worker.start_link(arg)
      # {Availability.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Availability.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

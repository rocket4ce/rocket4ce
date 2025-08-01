defmodule Rocket4ce.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Rocket4ceWeb.Telemetry,
      Rocket4ce.Repo,
      {DNSCluster, query: Application.get_env(:rocket4ce, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Rocket4ce.PubSub},
      # Start a worker by calling: Rocket4ce.Worker.start_link(arg)
      # {Rocket4ce.Worker, arg},
      # Start to serve requests, typically the last entry
      Rocket4ceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Rocket4ce.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Rocket4ceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

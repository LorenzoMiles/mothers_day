defmodule MothersDay.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MothersDayWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:mothers_day, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MothersDay.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MothersDay.Finch},
      # Start a worker by calling: MothersDay.Worker.start_link(arg)
      # {MothersDay.Worker, arg},
      # Start to serve requests, typically the last entry
      MothersDayWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MothersDay.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MothersDayWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

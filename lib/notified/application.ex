defmodule Notified.Application do
  use Application

  def start(_type, _args) do
    children = [
      Notified.Repo
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Notified.Supervisor)
  end
end

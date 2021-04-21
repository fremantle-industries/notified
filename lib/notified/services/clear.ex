defmodule Notified.Services.Clear do
  alias Notified.{Config, Repo, Queries, Topic}

  def call do
    # etso doesn't support delete_all yet
    # Repo.delete_all(Notification)

    nil
    |> Queries.SearchQuery.call()
    |> Repo.all()
    |> Enum.each(&Repo.delete/1)

    msg = {:notified, :clear}
    Phoenix.PubSub.broadcast(Config.pubsub_server(), Topic.clear(), msg)
  end
end

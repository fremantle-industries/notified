defmodule Notified.Services.MarkSeen do
  alias Notified.{Config, Notification, Repo, Topic}

  def call(notification) do
    notification
    |> update
    |> pubsub_send()
  end

  defp update(notification) do
    notification
    |> Notification.changeset(%{seen_at: DateTime.utc_now(), seen: true})
    |> Repo.update()
  end

  def pubsub_send({:ok, notification} = result) do
    msg = {:notified, :mark_seen, notification.id}
    Phoenix.PubSub.broadcast(Config.pubsub_server(), Topic.mark_seen("*"), msg)
    Phoenix.PubSub.broadcast(Config.pubsub_server(), Topic.mark_seen(notification.id), msg)
    result
  end

  def pubsub_send({:error, _} = error) do
    error
  end
end

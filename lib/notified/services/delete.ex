defmodule Notified.Services.Delete do
  alias Notified.{Config, Repo, Topic}

  def call(notification) do
    notification
    |> delete
    |> pubsub_send()
  end

  defp delete(notification) do
    Repo.delete(notification)
  end

  def pubsub_send({:ok, notification} = result) do
    msg = {:notified, :delete, notification.id}
    Phoenix.PubSub.broadcast(Config.pubsub_server(), Topic.delete("*"), msg)
    Phoenix.PubSub.broadcast(Config.pubsub_server(), Topic.delete(notification.id), msg)
    result
  end

  def pubsub_send({:error, _} = error) do
    error
  end
end

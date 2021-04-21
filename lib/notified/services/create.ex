defmodule Notified.Services.Create do
  alias Notified.{Config, Notification, Repo, Topic}

  @type subject :: String.t()
  @type message :: String.t()
  @type tags :: [String.t()]
  @type notification :: Notification.t()

  @spec call(subject, message, tags) :: {:ok, notification} | {:error, Ecto.Changeset.t()}
  def call(subject, message, tags) do
    {subject, message, tags}
    |> insert()
    |> send()
  end

  defp insert({subject, message, tags}) do
    %Notification{}
    |> Notification.changeset(%{
      subject: subject,
      message: message,
      tags: tags,
      seen: false
    })
    |> Repo.insert()
  end

  defp send({:ok, notification} = result) do
    notification
    |> pubsub_send()
    |> receivers_send()

    result
  end

  defp send({:error, _} = error) do
    error
  end

  defp pubsub_send(notification) do
    msg = {:notified, :create, notification.id}
    Phoenix.PubSub.broadcast(Config.pubsub_server(), Topic.create("*"), msg)
    Phoenix.PubSub.broadcast(Config.pubsub_server(), Topic.create(notification.id), msg)
    notification
  end

  defp receivers_send(notification) do
    Notified.Receivers.send(notification)
  end
end

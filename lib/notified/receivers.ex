defmodule Notified.Receivers do
  alias Notified.{Config, Receiver, Topic}

  def send(notification) do
    Notified.Config.receivers()
    |> Enum.map(fn {mod, attrs} ->
      if attrs != nil do
        struct!(mod, attrs)
      end
    end)
    |> Enum.filter(& &1)
    |> Enum.map(fn receiver ->
      :ok = Receiver.send(receiver, notification)
      receiver
    end)
    |> Enum.each(fn receiver ->
      pubsub_server = Config.pubsub_server()
      msg = {:notified, :receiver_sent, {receiver, notification}}
      Phoenix.PubSub.broadcast(pubsub_server, Topic.receiver_sent(notification.id), msg)
      Phoenix.PubSub.broadcast(pubsub_server, Topic.receiver_sent("*"), msg)
    end)
  end
end

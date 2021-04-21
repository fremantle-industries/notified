defmodule Notified.Receivers do
  def send(notification) do
    Notified.Config.receivers()
    |> Enum.map(fn {mod, attrs} ->
      if attrs != nil do
        struct!(mod, attrs)
      end
    end)
    |> Enum.filter(& &1)
    |> Enum.each(&Notified.Receiver.send(&1, notification))
  end
end

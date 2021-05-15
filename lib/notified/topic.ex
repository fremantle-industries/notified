defmodule Notified.Topic do
  @spec create(integer | String.t()) :: String.t()
  def create(id), do: "notified:create:#{id}"

  @spec mark_seen(integer | String.t()) :: String.t()
  def mark_seen(id), do: "notified:mark_seen:#{id}"

  @spec delete(integer | String.t()) :: String.t()
  def delete(id), do: "notified:delete:#{id}"

  @spec clear :: String.t()
  def clear, do: "notified:clear"

  @spec receiver_sent(integer | String.t()) :: String.t()
  def receiver_sent(id), do: "notified:receiver_sent:#{id}"
end

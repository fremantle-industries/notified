defmodule Notified.Topic do
  @spec create(integer | String.t()) :: String.t()
  def create(id), do: "create:#{id}"

  @spec mark_seen(integer | String.t()) :: String.t()
  def mark_seen(id), do: "mark_seen:#{id}"

  @spec delete(integer | String.t()) :: String.t()
  def delete(id), do: "delete:#{id}"

  @spec clear :: String.t()
  def clear, do: "clear"
end

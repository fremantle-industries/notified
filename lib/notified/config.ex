defmodule Notified.Config do
  def fetch_env!(key) do
    Confex.fetch_env!(:notified, key)
  end

  def valid? do
    true
  end

  @spec receivers :: [{module, keyword}]
  def receivers do
    fetch_env!(:receivers)
  end

  @spec pubsub_server :: module
  def pubsub_server do
    fetch_env!(:pubsub_server)
  end
end

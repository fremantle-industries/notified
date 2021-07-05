defmodule Notified.Queries.UnseenQuery do
  import Ecto.Query
  alias Notified.Notification

  @doc """
  Return a query that only returns notifications that haven't been seen.
  """
  @spec call :: Ecto.Query.t()
  def call do
    from(n in Notification, where: is_nil(n.seen_at))
  end
end

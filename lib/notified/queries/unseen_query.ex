defmodule Notified.Queries.UnseenQuery do
  import Ecto.Query
  alias Notified.Notification

  @doc """
  Return a query that only returns notifications that haven't been seen.

  The etso adapter only has basic query support and does not support `is_nil`
  or aggregate yet. For now, we can use an extra boolean field.
  https://github.com/evadne/etso/issues/15
  """
  @spec call :: Ecto.Query.t()
  def call do
    from(n in Notification, where: n.seen == false)
  end
end

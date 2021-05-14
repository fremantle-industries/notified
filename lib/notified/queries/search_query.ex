defmodule Notified.Queries.SearchQuery do
  import Ecto.Query
  alias Notified.Notification

  def call(_search_term) do
    from(Notification, order_by: [asc: :inserted_at])
  end
end

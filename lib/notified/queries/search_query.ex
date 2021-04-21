defmodule Notified.Queries.SearchQuery do
  import Ecto.Query
  alias Notified.Notification

  def call(_search_term) do
    from(Notification)
  end
end

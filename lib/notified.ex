defmodule Notified do
  @moduledoc """
  This module is the facade for managing notifications with `notified`
  """

  alias Notified.{Notification, Repo, Services, Queries}

  @type subject :: String.t()
  @type message :: String.t()
  @type tags :: [String.t()]
  @type search_term :: String.t()
  @type notification :: Notification.t()

  @spec create(subject, message, tags) :: {:ok, notification} | {:error, Ecto.Changeset.t()}
  def create(subject, message, tags) do
    Services.Create.call(subject, message, tags)
  end

  @spec mark_seen(Ecto.Changeset.t()) :: {:ok, notification} | {:error, Ecto.Changeset.t()}
  def mark_seen(notification) do
    Services.MarkSeen.call(notification)
  end

  @spec delete(notification) :: {:ok, notification} | {:error, Ecto.Changeset.t()}
  def delete(notification) do
    Services.Delete.call(notification)
  end

  @spec clear :: :ok | {:error, term}
  def clear do
    Services.Clear.call()
  end

  @spec get!(integer) :: {:ok, notification} | {:error, term}
  def get!(id) do
    Repo.get!(Notification, id)
  end

  @default_page 1
  @default_page_size 25

  @spec search(search_term, list) :: [notification]
  def search(search_term, opts) do
    page = opts[:page] || @default_page
    page_size = opts[:page_size] || @default_page_size

    search_term
    |> Queries.SearchQuery.call()
    |> PagedQuery.call(page, page_size)
    |> Repo.all()
  end

  @spec search_count(search_term) :: non_neg_integer
  def search_count(search_term) do
    search_term
    |> Queries.SearchQuery.call()
    |> Repo.all()
    |> Enum.count()
  end

  @spec count_unseen :: non_neg_integer
  def count_unseen do
    Queries.UnseenQuery.call()
    |> Repo.all()
    |> Enum.count()
  end
end

defmodule Notified.CountUnseenTest do
  use Notified.DataCase, async: false

  test "returns the number of notifications that have not been seen" do
    {:ok, _} = create_notification(%{subject: "Unseen", seen_at: nil})
    {:ok, _} = create_notification(%{subject: "Seen", seen_at: DateTime.utc_now()})

    assert Notified.count_unseen() == 1
  end

  @base_attrs %{subject: "Subject", message: "Message", tags: [], seen_at: nil}
  defp create_notification(attrs) do
    merged_attrs = Map.merge(@base_attrs, attrs)

    %Notified.Notification{}
    |> Notified.Notification.changeset(merged_attrs)
    |> Notified.Repo.insert()
  end
end

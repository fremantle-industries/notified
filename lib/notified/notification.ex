defmodule Notified.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "notifications" do
    field(:subject, :string)
    field(:message, :string)
    field(:tags, {:array, :string})
    field(:seen_at, :utc_datetime_usec)
    field(:seen, :boolean)

    timestamps()
  end

  def changeset(notification, attrs) do
    notification
    |> cast(attrs, ~w[subject message tags seen_at seen]a)
    |> validate_required(~w[subject message]a)
  end
end

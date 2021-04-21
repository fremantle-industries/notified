defmodule Notified.Receivers.Email do
  @type t :: %__MODULE__{
          addresses: [String.t()]
        }

  @enforce_keys ~w[addresses]a
  defstruct ~w[addresses]a

  defimpl Notified.Receiver do
    def send(receiver, notification) do
      receiver.addresses
      |> Enum.each(fn to ->
        Notified.Email.base_email(to, notification)
        |> Notified.Mailer.deliver_now!()
      end)
    end
  end
end

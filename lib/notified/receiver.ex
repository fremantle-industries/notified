defprotocol Notified.Receiver do
  @type receiver :: struct
  @type notification :: Notified.Notification.t()

  @spec send(receiver, notification) :: :ok
  def send(receiver, notification)
end

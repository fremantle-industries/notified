defmodule Notified.Email do
  import Bamboo.Email

  def base_email(to, notification) do
    from = Notified.Config.fetch_env!(:from)

    new_email(
      to: to,
      from: from,
      subject: notification.subject,
      html_body: notification.message,
      text_body: notification.message
    )
  end
end

# Notified

[![Build Status](https://github.com/fremantle-industries/notified/workflows/test/badge.svg?branch=main)](https://github.com/fremantle-industries/notified/actions?query=workflow%3Atest)
[![hex.pm version](https://img.shields.io/hexpm/v/notified.svg?style=flat)](https://hex.pm/packages/notified)

An Elixir library for application notifications

This library is the core notification engine. For a frontend phoenix live UI check out [notified_phoenix](https://github.com/fremantle-industries/notified_phoenix)

## Installation

Add the `notified` package to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:notified, "~> 0.0.4"}]
end
```

## Configuration

Configure the pubsub server

```elixir
config :notified, pubsub_server: MyApp.PubSub
config :notified, from: "notifier@tesla.com"
config :notified, Notified.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.gmail.com",
  hostname: "tesla.com",
  port: 1025,
  username: "notified@tesla.com",
  password: "volts",
  tls: :if_available, # can be `:always` or `:never`
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"], # or {:system, "ALLOWED_TLS_VERSIONS"} w/ comma seprated values (e.g. "tlsv1.1,tlsv1.2")
  ssl: false, # can be `true`
  retries: 1,
  no_mx_lookups: false, # can be `true`
  auth: :if_available # can be `:always`. If your smtp relay requires authentication set it to `:always`.
```

Configure forwarding receivers

```elixir
config :notified, receivers: [
  {Notified.Receivers.MmsGateway, addresses: ["5555555555@mypixmessages.com"]}
  {Notified.Receivers.Email, addresses: ["elon@tesla.com"]}
]
```

## Usage

Create & manage a notification

```elixir
notification = Notifed.create("Many Signups!", "10 users have signed up in the last 5 minutes", ["users", "campaign-1"])
Notifed.mark_seen(notification)
Notifed.delete(notification)
```

Notifications are stored in memory using ETS via [etso](https://github.com/evadne/etso). This
means that notifications will not persist between application restarts.

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`notified` is released under the [MIT license](./LICENSE)

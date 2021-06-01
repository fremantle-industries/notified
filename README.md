# Notified

[![Build Status](https://github.com/fremantle-industries/notified/workflows/test/badge.svg?branch=main)](https://github.com/fremantle-industries/notified/actions?query=workflow%3Atest)
[![hex.pm version](https://img.shields.io/hexpm/v/notified.svg?style=flat)](https://hex.pm/packages/notified)

An Elixir library for application notifications

This library is the core notification engine. For a frontend phoenix live UI check out [notified_phoenix](https://github.com/fremantle-industries/notified_phoenix)

## Installation

Add the `notified` package to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:notified, "~> 0.0.5"}]
end
```

## Configuration

Configure the pubsub server

```elixir
config :notified, pubsub_server: MyApp.PubSub
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

# Notified

An Elixir library for application notifications

## Installation

Add the `notified` package to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:notified, "~> 0.0.2"}]
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

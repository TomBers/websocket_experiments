# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :socketserver,
  ecto_repos: [Socketserver.Repo]

# Configures the endpoint
config :socketserver, SocketserverWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3nlCguWR+Eep7P/Gby+xv1bTIu4VbHXB2lRxs32Pu7HRgkEI2Q/XCbWkCQ/88ubn",
  render_errors: [view: SocketserverWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Socketserver.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

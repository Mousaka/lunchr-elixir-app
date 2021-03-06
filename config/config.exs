# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :luncher,
  ecto_repos: [Luncher.Repo]

# Configures the endpoint
config :luncher, Luncher.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nkYEXV8sixL0RkOYrstbuGNUEU40QonzT5SsvRrN7okqe0vnjkIIYMG1WgXIbUjO",
  render_errors: [view: Luncher.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Luncher.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :luncher, Google,
    client_id: System.get_env("CLIENT_ID"),
    client_secret: System.get_env("CLIENT_SECRET"),
    redirect_uri: System.get_env("REDIRECT_URI")

config :luncher, GitHub,
    client_id: System.get_env("GITHUB_CLIENT_ID"),
    client_secret: System.get_env("GITHUB_CLIENT_SECRET"),
    redirect_uri: System.get_env("GITHUB_REDIRECT_URI")
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

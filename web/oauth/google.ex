defmodule Google do
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
      [strategy: Google,
       site: "https://accounts.google.com",
       authorize_url: "/o/oauth2/auth",
       token_url: "/o/oauth2/token"]
  end

  def client do
    Application.get_env(:luncher, Google)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def authorize_url!(params \\ []) do
    OAuth2.Client.authorize_url!(client(), params)
  end

  def get_token!(params \\ [], headers \\ []) do
    OAuth2.Client.get_token!(client(), params, headers)
  end

  # strategy callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end

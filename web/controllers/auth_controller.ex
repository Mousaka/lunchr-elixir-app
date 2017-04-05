# web/controllers/auth_controller.ex
defmodule Luncher.AuthController do
  use Luncher.Web, :controller

  def index(conn, %{"provider" => provider}) do
    redirect conn, external: authorize_url!(provider)
  end

  def callback(conn, %{"provider" => provider, "code" => code}) do
    token = get_token!(provider, code)
    user = get_user!(provider, token)
    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, token.token.access_token)
    #|> put_session(:access_token, token.access_token)
    |> redirect(to: "/")
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp authorize_url!("google") do
    Google.authorize_url!(scope: "email profile")
  end

  defp authorize_url!("github") do
    GitHub.authorize_url!
  end

  defp authorize_url!(_) do
    raise "No matching provider available"
  end

  defp get_token!("google", code) do
    Google.get_token!(code: code)
  end

    defp get_token!("github", code) do
      GitHub.get_token!(code: code)
    end

  defp get_token!(_, _) do
    raise "No matching provider available"
  end

  defp get_user!("google", token) do
    user_url = "https://www.googleapis.com/plus/v1/people/me/openIdConnect"
    OAuth2.Client.get!(token, user_url)
  end


  defp get_user!("github", client) do
    %{body: user} = OAuth2.Client.get!(client, "/user")
    %{name: user["name"], avatar: user["avatar_url"]}
  end
end

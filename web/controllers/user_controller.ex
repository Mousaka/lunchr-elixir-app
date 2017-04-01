# web/controllers/user_controller
defmodule Luncher.UserController do
  use Luncher.Web, :controller

def index(conn, _params) do
    users = [
      %{name: "Joe",
        email: "joe@example.com",
        password: "topsecret",
        stooge: "meeoe"},

      %{name: "Anneblah",
        email: "anne@example.com",
        password: "guessme",
        stooge: "larry"},

      %{name: "Franklin",
        email: "franklin@example.com",
        password: "guessme",
        stooge: "curly"},
    ]

    json conn, users
  end
end

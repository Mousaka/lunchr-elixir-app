defmodule Luncher.PageController do
  use Luncher.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

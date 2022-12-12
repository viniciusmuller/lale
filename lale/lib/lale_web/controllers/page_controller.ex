defmodule LaleWeb.PageController do
  use LaleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

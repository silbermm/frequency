defmodule Frequency.Web.PageController do
  use Frequency.Web, :controller

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render conn, "index.html", %{ "elm_module": "/js/main.js" }
  end
end

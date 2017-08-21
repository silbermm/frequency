defmodule FrequencyWeb.PageController do
  use FrequencyWeb, :controller

  def index(conn, params) do
    user = Guardian.Plug.current_resource(conn)
    render conn, "index.html", user: user
  end
end

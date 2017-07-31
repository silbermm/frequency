defmodule FrequencyWeb.PageController do
  use FrequencyWeb, :controller

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render conn, "index.html", %{ "elm_module": "/js/main.js" }
  end
end

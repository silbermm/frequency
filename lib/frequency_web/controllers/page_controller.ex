defmodule FrequencyWeb.PageController do
  use FrequencyWeb, :controller
  alias FrequencyWeb.Plugs.IncludeUserPlug
  alias Frequency.Radio

  plug IncludeUserPlug

  def index(conn, params) do
    jwt = Guardian.Plug.current_token(conn)
    #stations = Frequency.NPR.stations()
    conn
    |> render "index.html", [
      jwt: jwt
    ]
  end
end

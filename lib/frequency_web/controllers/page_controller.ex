defmodule FrequencyWeb.PageController do
  use FrequencyWeb, :controller
  alias FrequencyWeb.Plugs.IncludeUserPlug
  alias Frequency.Radio

  plug IncludeUserPlug

  def index(conn, params) do
    # load all radio stations...
    # this may eventually be too large a call
    jwt = Guardian.Plug.current_token(conn)
    stations = Radio.stations()
    conn
    |> put_resp_header("authorization", "Bearer #{jwt}")
    |> render "index.html", stations: stations, jwt: jwt
  end
end

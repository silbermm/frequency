defmodule FrequencyWeb.PageController do
  use FrequencyWeb, :controller
  alias FrequencyWeb.Plugs.IncludeUserPlug
  alias Frequency.Radio

  plug IncludeUserPlug

  def index(conn, params) do
    # load all radio stations...
    # this may eventually be too large a call
    stations = Radio.stations()
    render conn, "index.html", stations: stations
  end
end

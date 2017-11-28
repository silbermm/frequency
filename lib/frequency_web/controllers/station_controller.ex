defmodule FrequencyWeb.StationController do
  use FrequencyWeb, :controller

  alias FrequencyWeb.Plugs.IncludeUserPlug
  plug IncludeUserPlug

  def index(conn, params) do
    stations = Frequency.NPR.stations()
    render conn, "index.json", stations: stations
  end

end

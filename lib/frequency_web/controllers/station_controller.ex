defmodule FrequencyWeb.StationController do
  use FrequencyWeb, :controller

  alias FrequencyWeb.Plugs.IncludeUserPlug
  plug IncludeUserPlug

  def index(conn, %{"lat" => latitude, "long" => longitude} = _params) do
    stations = Frequency.NPR.stations(lat: latitude, lon: longitude)
    render conn, "index.json", stations: stations
  end

  def index(conn, params) do
    IO.inspect params
    stations = Frequency.NPR.stations()
    render conn, "index.json", stations: stations
  end

end

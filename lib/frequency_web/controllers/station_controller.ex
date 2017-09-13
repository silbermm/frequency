defmodule FrequencyWeb.StationController do
  use FrequencyWeb, :controller

  def get(conn, %{"station_id" => station_id} = params) do
    station = Frequency.Radio.get_station(station_id)
    render conn, "station.html", station: station
  end
end

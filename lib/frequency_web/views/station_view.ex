defmodule FrequencyWeb.StationView do
  use FrequencyWeb, :view

  def render("index.json", %{stations: stations}) do
    render_many(stations, FrequencyWeb.StationView, "station.json")
  end

  def render("station.json", %{station: station}) do
    station
  end
end

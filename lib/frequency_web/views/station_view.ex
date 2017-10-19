defmodule FrequencyWeb.StationView do
  use FrequencyWeb, :view

  def render("index.json", %{stations: stations}) do
    %{data: render_many(stations, FrequencyWeb.StationView, "station.json")}
  end

  #def render("show.json", %{todo: todo}) do
    #%{data: render_one(todo, TodoApi.TodoView, "todo.json")}
  #end

  def render("station.json", %{station: station}) do
    %{id: station.id,
      call_letters: station.call_letters,
      channel: station.channel,
      website: station.website,
      station_strengths: render_many(station.station_strengths, FrequencyWeb.StationStrengthView, "station_strength.json")}
  end
end

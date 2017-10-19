defmodule FrequencyWeb.StationController do
  use FrequencyWeb, :controller
  alias Frequency.Radio
  alias FrequencyWeb.Plugs.IncludeUserPlug

  plug IncludeUserPlug

  def index(conn, _params) do
    stations = Radio.stations()
    render conn, "index.json", stations: stations
  end

  def get(conn, %{"station_id" => station_id} = params) do
    station = Radio.get_station(station_id)
    render conn, "station.html", station: station
  end

  def create_form(conn, _params) do
    changeset = Radio.station_changeset()
    render conn, "create.html", station: changeset
  end

  def create(conn, %{"station" => station}) do
    changeset = Radio.station_changeset(station)
    case Radio.create_station(changeset) do
      {:ok, _} -> 
        conn
        |> put_flash(:info, "Station Created")
        |> redirect to: "/"
      {:error, changeset} -> 
        conn
        |> put_flash(:error, "Please fix the errors below")
        |> render "create.html", station: changeset
    end
  end
end

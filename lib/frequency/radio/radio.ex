defmodule Frequency.Radio do
  alias Frequency.Repo
  alias Frequency.Radio.Station

  def get_station(station_id) do
    Repo.get(Station, station_id)
  end
end

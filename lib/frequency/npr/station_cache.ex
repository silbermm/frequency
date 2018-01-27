defmodule Frequency.NPR.StationCache do
  @moduledoc """
  If we've already queried the NPR server for stations based on a particular GeoLocation, there is no need to do it again (at least for a while). This module keeps track of the locations queried.

  There is also a default distance threshold of 2 miles. One can increase the threashold by setting the appropriate config setting `config :frequency, station_distance_theshold: 5`
  """
  use GenServer
  alias Frequency.NPR.Station

  defstruct [:lat, :lon, :expires, :stations]

  @name __MODULE__
  @threshold Application.get_env(:frequency, :station_distance_threshold, 2)
  @cache_timeout Application.get_env(:frequency, :state_cache_time, 300)

  @doc false
  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, @name)
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc false
  def init(:ok) do
    {:ok, []}
  end

  @doc """
  Do the lat and lon coordinates exist in the cache?
  """
  @spec check_coordinates(float(), float()) :: :empty | {:ok, list(Station.t)}
  def check_coordinates(lat, lon) do
    GenServer.call(@name, {:check_coordinates, lat, lon}, 5000)
  end

  @spec set_coordinates(float(), float(), list(Station.t)) :: :ok | {:error, String.t}
  def set_coordinates(lat, lon, stations) do
    GenServer.cast(@name, {:set_coordinates, lat, lon, stations})
  end

  @doc false
  def handle_call({:check_coordinates, lat, lon}, _from, state) do
    state = Enum.drop_while(state, &(is_expired?(&1)))
    result =
      state
      |> Enum.filter(fn(e) ->
        ((e.lat == lat && e.lon == lon)
        || (check_distance(e.lat, e.lon, lat, lon) <= @threshold))
      end)
      |> case do
        [] -> :empty
        stations -> Enum.flat_map(stations, &(&1.stations))
      end
    {:reply, result, state}
  end

  @doc false
  def handle_cast({:set_coordinates, lat, lon, stations}, state) do
    cache = %__MODULE__{lat: lat, lon: lon, stations: stations, expires: expires()}
    state = state ++ [cache]
    {:noreply, state}
  end

  defp check_distance(lat, lon, other_lat, other_lon) do
    Frequency.GeoDistance.calculate(lat, lon, other_lat, other_lon)
  end

  defp expires do
    NaiveDateTime.utc_now
    |> NaiveDateTime.add(@cache_timeout)
  end

  defp is_expired?(cache_item) do
    NaiveDateTime.utc_now
    |> NaiveDateTime.compare(cache_item.expires)
    |> case do
      :gt -> true
      :lt -> false
      _ -> true
    end
  end
end

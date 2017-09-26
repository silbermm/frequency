defmodule FrequencyWeb.PageView do
  use FrequencyWeb, :view

  @attributes [:id, :call_letters, :channel, :website, :latitude, :longitude]

  def as_json(stations) when is_list(stations) do
    stations
    |> Enum.map(fn(station) -> Map.take(station, @attributes) end)
    |> Poison.encode!
  end
  def as_json(station) do
    as_json([station])
  end
end

defmodule Frequency.NPR do

  import Focus
  defstruct id: 1, frequency: "", band: "", call_letters: "", logo: %{}, stream: ""

  def stations([lat: latitude, lon: longitude] = opts) do
    lat = String.to_float(latitude)
    lon = String.to_float(longitude)
    case Frequency.NPR.StationCache.check_coordinates(lat, lon) do
      :empty ->
        stations = get_stations(opts)
        Frequency.NPR.StationCache.set_coordinates(lat,lon,stations)
        stations
      stations -> stations
    end
  end
  def stations(opts \\ []), do: get_stations(opts)

  def to_struct(results) do
    lenses = make_lenses()
    Stream.map(results, fn(station) ->
      %__MODULE__{
        id: lenses.attributes ~> lenses.network ~> lenses.currentOrg |> Focus.view(station),
        frequency: lenses.attributes ~> lenses.brand ~> lenses.frequency |> Focus.view(station),
        band: lenses.attributes ~> lenses.brand ~> lenses.band |> Focus.view(station),
        call_letters: station["attributes"]["brand"]["call"],
        logo: build_logo(station["links"]["brand"])
      }
    end)
  end

  defp make_lenses() do
    %{
      attributes: Lens.make_lens("attributes"),
      network: Lens.make_lens("network"),
      currentOrg: Lens.make_lens("currentOrgId"),
      brand: Lens.make_lens("brand"),
      frequency: Lens.make_lens("frequency"),
      band: Lens.make_lens("band"),
      call: Lens.make_lens("call"),
      links: Lens.make_lens("links")
    }
  end

  defp get_stations(opts) do
    {:ok, npr_token} = NPRx.Auth.authenticate_client()
    npr_token
    |> NPRx.StationFinder.stations(opts)
    |> case do
      {:ok, results} ->
        results
        |> to_struct
        |> Enum.sort_by(fn(r) -> r.call_letters end)
      {:error, reason} -> []
    end
  end

  defp build_logo(links) do
    links
    |> Enum.find(fn(link) -> link["rel"] == "small-logo" end)
  end
end

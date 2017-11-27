defmodule Frequency.NPR do

  defstruct id: 0, frequency: "", band: "", call_letters: "", logo: %{}, stream: ""

  def stations() do
    {:ok, npr_token} = NPRx.Auth.authenticate_client()
    npr_token
    |> NPRx.StationFinder.stations
    |> case do
      {:ok, results} -> to_struct(results)
      {:error, reason} -> []
    end
  end

  def to_struct(results) do
    res = Stream.map(results, fn(station) ->
      %__MODULE__{
        id: station["attributes"]["network"]["currentOrgId"],
        frequency: station["attributes"]["brand"]["frequency"],
        band: station["attributes"]["brand"]["band"],
        call_letters: station["attributes"]["brand"]["call_letters"],
        logo: build_logo(station["links"]["brand"])
      }
    end)
    IO.inspect res
    res
  end

  defp build_logo(links) do
    links
    |> Enum.find(fn(link) -> link["rel"] == "small-logo" end)
  end
end

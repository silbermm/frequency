defmodule FrequencyWeb.PageViewTest do
  use FrequencyWeb.ConnCase, async: true

  alias Frequency.Repo
  alias Frequency.Radio.Station

  test "render stations as json" do
    station = %Station{call_letters: "WNKU", channel: "89.7", website: "https://wnku.org"}
    {:ok, station} = Repo.insert(station)
    json = FrequencyWeb.PageView.as_json(Repo.all(Station))
    assert json == ~s([{"website":"https://wnku.org","longitude":null,"latitude":null,"id":#{station.id},"channel":"89.7","call_letters":"WNKU"}])
  end

  test "render one station as json" do
    station = %Station{call_letters: "WNKU", channel: "89.7", website: "https://wnku.org"}
    {:ok, station} = Repo.insert(station)
    json = FrequencyWeb.PageView.as_json(station)
    assert json == ~s([{"website":"https://wnku.org","longitude":null,"latitude":null,"id":#{station.id},"channel":"89.7","call_letters":"WNKU"}])
  end
end

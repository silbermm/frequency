defmodule FrequencyWeb.StationControllerTest do
  use FrequencyWeb.ConnCase

  alias Frequency.Radio.Station

  test "GET /station/:id", %{conn: conn} do
    station = %Station{ call_letters: "WVXU", channel: "91.7", website: "https://wvxu.org" }
    {:ok, station_inserted} = Frequency.Repo.insert(station)
    conn = get conn, "/station/#{station_inserted.id}"
    assert html_response(conn, 200) =~ "WVXU"
  end
end

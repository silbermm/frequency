defmodule FrequencyWeb.StationControllerTest do
  use FrequencyWeb.ConnCase

  alias Frequency.Radio.Station

  test "GET /station/:id", %{conn: conn} do
    station = %Station{ call_letters: "WVXU", channel: "91.7", website: "https://wvxu.org" }
    {:ok, station_inserted} = Frequency.Repo.insert(station)
    conn = get conn, "/station/#{station_inserted.id}"
    assert html_response(conn, 200) =~ "WVXU"
  end

  test "GET /station/create", %{conn: conn} do
    conn = get conn, "/station/create"
    assert html_response(conn, 200) =~ "form"
  end

  test "POST /station/create", %{conn: conn} do
    conn = post conn, "/station/create", %{"station" => %{call_letters: "WNKU", channel: "89.7", website: "https://wnku.org"}}
    station = Frequency.Repo.get_by(Station, call_letters: "WNKU")
    assert html_response(conn, 302)
    assert station.call_letters == "WNKU"
  end

  test "POST /station shows success message", %{conn: conn} do
    conn = post conn, "/station/create", %{"station" => %{call_letters: "WNKU", channel: "89.7", website: "https://wnku.org"}}
    station = Frequency.Repo.get_by(Station, call_letters: "WNKU")
    assert get_flash(conn, :info) == "Station Created"
  end


end

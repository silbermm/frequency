defmodule FrequencyWeb.StationControllerTest do
  use FrequencyWeb.ConnCase

  alias Frequency.Radio.Station
  alias Frequency.Authentication.User
  alias Frequency.Repo

  setup do
    changeset = %User{username: "silbermm", email: "silbermm@gmail.com"}
    {:ok, user} = Repo.insert(changeset)
    {:ok, %{user: user}}
  end

  test "GET /station/:id", %{conn: conn, user: user} do
    conn = guardian_login(conn, user)
    station = %Station{ call_letters: "WVXU", channel: "91.7", website: "https://wvxu.org" }
    {:ok, station_inserted} = Frequency.Repo.insert(station)
    conn = get conn, "/station/#{station_inserted.id}"
    assert html_response(conn, 200) =~ "WVXU"
  end

  test "GET /station/create", %{conn: conn, user: user} do
    conn = conn
           |> guardian_login(user)
           |> get "/station/create"
    assert html_response(conn, 200) =~ "form"
  end

  test "POST /station/create", %{conn: conn, user: user} do
    conn = 
      conn
      |> guardian_login(user)
      |> post "/station/create", %{"station" => %{call_letters: "WNKU", channel: "89.7", website: "https://wnku.org"}}
    station = Frequency.Repo.get_by(Station, call_letters: "WNKU")
    assert html_response(conn, 302)
    assert station.call_letters == "WNKU"
  end

  test "POST /station shows success message", %{conn: conn, user: user} do
    conn =
      conn
      |> guardian_login(user)
      |> post "/station/create", %{"station" => %{call_letters: "WNKU", channel: "89.7", website: "https://wnku.org"}}
    station = Frequency.Repo.get_by(Station, call_letters: "WNKU")
    assert get_flash(conn, :info) == "Station Created"
  end
end

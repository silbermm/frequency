defmodule FrequencyWeb.IncludeUserPlugTest do
  use FrequencyWeb.ConnCase

  alias Frequency.Radio.Station
  alias Frequency.Authentication.User
  alias Frequency.Repo
  alias FrequencyWeb.Plugs.IncludeUserPlug

  setup do
    changeset = %User{username: "silbermm", email: "silbermm@gmail.com"}
    {:ok, user} = Repo.insert(changeset)
    {:ok, %{user: user}}
  end

  test "logged in user included in assigns for /", %{conn: conn, user: user} do
    conn =
      conn
      |> guardian_login(user)
      |> get "/"
    assert conn.assigns.loggedin_user == user
  end

  test "logged in user included in assigns for /station/:id", %{conn: conn, user: user} do
    conn = guardian_login(conn, user)
    station = %Station{ call_letters: "WVXU", channel: "91.7", website: "https://wvxu.org" }
    {:ok, station_inserted} = Frequency.Repo.insert(station)
    conn = get conn, "/station/#{station_inserted.id}"
    assert conn.assigns.loggedin_user == user
  end

end

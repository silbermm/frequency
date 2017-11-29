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
end

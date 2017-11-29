defmodule FrequencyWeb.StationControllerTest do
  use FrequencyWeb.ConnCase
  import Mock
  alias Frequency.Radio.Station
  alias Frequency.Authentication.User
  alias Frequency.Repo

  setup do
    changeset = %User{username: "silbermm", email: "silbermm@gmail.com"}
    {:ok, user} = Repo.insert(changeset)
    {:ok, %{user: user}}
  end

  test "GET /api/stations", %{conn: conn, user: user} do
    with_mock Frequency.NPR, [stations: fn() -> [%Frequency.NPR{ call_letters: "WVXU", frequency: "91.7", band: "PM", id: "123" }] end] do
      conn = guardian_login(conn, user)
      conn = get conn, "/api/stations"
      assert json_response(conn, 200) == [%{"band" => "PM", "call_letters" => "WVXU", "frequency" => "91.7", "id" => "123", "logo" => %{}, "stream" => ""}]
    end
  end

end

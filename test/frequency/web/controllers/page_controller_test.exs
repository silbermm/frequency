defmodule FrequencyWeb.PageControllerTest do
  use FrequencyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Frequency"
  end
end

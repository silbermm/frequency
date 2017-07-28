defmodule Frequency.Web.LoginController do
  use Frequency.Web, :controller
  alias Frequency.Authentication
  require Logger


  @doc """
    Show the login form
  """
  def index(conn, _params) do
    render conn, "index.html", %{ "elm_module": "/js/login.js" }
  end

  def login(conn, %{ "username" => username, "password" => password } = params) do
    case Authentication.login(username, password) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", %{})
      user ->
        {:ok, jwt, claims} = Guardian.encode_and_sign(user, :access)
        #exp = Map.get(claims, "exp")
        conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        #|> put_resp_header("x-expires", exp)
        |> put_status(:ok)
        |> render("login.json", %{jwt: jwt})
    end
  end
end

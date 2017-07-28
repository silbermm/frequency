defmodule Frequency.Web.TokenController do
  use Frequency.Web, :controller
  alias Frequency.Authentication
  require Logger

  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  def verify(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn
    |> render("user.json", user: user )
  end

  def delete(conn, _params) do
    jwt = Guardian.Plug.current_resource(conn)
    revoked = case Guardian.Plug.claims(conn) do
      {:ok, claims} -> Guardian.revoke!(jwt, claims)
      _ -> Guardian.revoke!(jwt)
    end
    render conn, "logout.json"
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render "error.json", message: "Authentication required"
  end
end

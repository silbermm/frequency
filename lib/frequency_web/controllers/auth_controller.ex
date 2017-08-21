defmodule FrequencyWeb.AuthController do
  use FrequencyWeb, :controller

  plug Ueberauth

  alias Frequency.Authentication
  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    user = Authentication.user_changeset()
    render(conn, "request.html", callback_url: Helpers.callback_url(conn), user: user)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case Frequency.Authentication.OauthUser.find_or_create(auth) do
      {:ok, user} ->
        {:ok, jwt, claims} = Guardian.encode_and_sign(user, :access)
        conn
        |> put_resp_header("Authorization", "Bearer #{jwt}")
        |> render("login.html", jwt: jwt)
      {:error, changeset} ->
        conn
        |> put_flash(:error, "invalid form")
        |> render("request.html", callback_url: Helpers.callback_url(conn), user: changeset)
    end
  end

end

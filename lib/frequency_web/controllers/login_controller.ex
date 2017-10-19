defmodule FrequencyWeb.LoginController do
  use FrequencyWeb, :controller
  alias Frequency.Authentication
  require Logger


  @doc """
  Show the login form
  """
  def index(conn, _params) do
    changeset = Authentication.login_changeset(%{})
    render conn, "index.html", user: changeset
  end

  @doc """
  Handle the login and redirect to the index page
  """
  def login(conn, %{"user" => user_params}) do
    changeset = Authentication.login_changeset(user_params)
    case Authentication.login(changeset) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> Guardian.Plug.api_sign_in(user)
        |> put_flash(:info, "Welcome")
        |> redirect to: page_path(conn, :index)
      {:error, changeset} ->
        render conn, "index.html", user: changeset
    end
  end
end

defmodule FrequencyWeb.Router do
  use FrequencyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :browser_ensure_authed do
    plug Guardian.Plug.EnsureAuthenticated, %{handler: FrequencyWeb.AuthController}
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", FrequencyWeb do
    pipe_through [:browser]
    get "/logout", AuthController, :delete
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  scope "/", FrequencyWeb do
    pipe_through [:browser, :browser_session]
    get "/login", LoginController, :index
    post "/login", LoginController, :login
    get "/register", RegistrationController, :index
    post "/register", RegistrationController, :register
    get "/", PageController, :index
  end

end

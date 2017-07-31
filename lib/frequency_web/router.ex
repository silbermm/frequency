defmodule FrequencyWeb.Router do
  use FrequencyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", FrequencyWeb do
    pipe_through [:browser]
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/", FrequencyWeb do
    pipe_through [:browser] # Use the default browser stack
    get "/login", LoginController, :index
    get "/", PageController, :index
  end

  scope "/api", FrequencyWeb do
    pipe_through [:api, :api_auth]

    get    "/token", TokenController, :verify
    delete "/token", TokenController, :delete
    post   "/token", LoginController, :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", FrequencyWeb do
  #   pipe_through :api
  # end
end

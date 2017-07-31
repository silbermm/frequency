defmodule FrequencyWeb.TokenView do
  use FrequencyWeb, :view
  require IEx

  def render("user.json", %{ user: user }) do
    %{
      username: user.username,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      id: user.id
    }
  end

  def render("logout.json", _params) do
    %{ result: "loggedout" }
  end

  def render("error.json", message) do
    message
  end
end



defmodule FrequencyWeb.LoginView do
  use FrequencyWeb, :view

  def render("login.json", %{ jwt: jwt }) do
    %{jwt: jwt}
  end

  def render("error.json", data) do
    %{}
  end
end

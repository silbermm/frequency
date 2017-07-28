defmodule Frequency.Web.LoginView do
  use Frequency.Web, :view

  def render("login.json", %{ jwt: jwt }) do
    %{jwt: jwt}
  end

  def render("error.json", data) do
    %{}
  end
end

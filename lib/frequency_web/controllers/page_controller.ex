defmodule FrequencyWeb.PageController do
  use FrequencyWeb, :controller
  alias FrequencyWeb.Plugs.IncludeUserPlug

  plug IncludeUserPlug

  def index(conn, params) do
    render conn, "index.html"
  end
end

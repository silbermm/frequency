defmodule FrequencyWeb.Plugs.IncludeUserPlug do
  import Plug.Conn

  def init(default), do: nil

  def call(conn, default \\ nil) do
    case Guardian.Plug.current_resource(conn) do
      %Frequency.Authentication.User{} = user ->
        assign(conn, :loggedin_user, user)
      _ -> conn
    end
  end
end

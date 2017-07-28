defmodule Frequency.Authentication.GuardianSerializer do
  @behaviour Guardian.Serializer
  
  alias Frequency.Authentication
  alias Frequency.Authentication.User

  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: { :ok, Authentication.get_user(id) }
  def from_token(_), do: { :error, "Unknown resource type" }

end

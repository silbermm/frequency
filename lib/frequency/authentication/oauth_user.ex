defmodule Frequency.Authentication.OauthUser do
  @moduledoc """
  Retrieve the user information from an auth request
  """

  alias Frequency.Authentication
  alias Frequency.Authentication.User
  alias Ueberauth.Auth

  require IEx

  def find_or_create(%Auth{provider: :identity} = auth) do
    # create the user in the database
    case Authentication.create_user_from_auth(auth, :identity) do
      {:ok, model} -> {:ok, basic_info(auth)}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def find_or_create(%Auth{} = auth) do
    IEx.pry
    case Authentication.get_user_by_username(auth.info.email) do
      %Frequency.Authentication.User{} = user -> {:ok, user}
      _ -> case Authentication.create_user_from_auth(auth, auth.provider) do
            {:ok, model} -> {:ok, model}
            {:error, changeset} -> {:error, changeset}
           end
    end
  end

  defp basic_info(auth) do
    %{id: auth.uid, name: name_from_auth(auth), avatar: auth.info.image}
  end

  defp name_from_auth(auth) do
    if auth.info.name do
      auth.info.name
    else
      name = [auth.info.first_name, auth.info.last_name]
      |> Enum.filter(&(&1 != nil and &1 != ""))

      cond do
        length(name) == 0 -> auth.info.nickname
        true -> Enum.join(name, " ")
      end
    end
  end
end

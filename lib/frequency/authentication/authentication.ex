defmodule Frequency.Authentication do
  @moduledoc """
    The boundary for the Authentication system.
  """

  import Ecto.{Query, Changeset}, warn: false
  import Comeonin.Bcrypt, only: [hashpwsalt: 1, checkpw: 2, dummy_checkpw: 0]

  alias Frequency.Repo
  alias Frequency.Authentication.User

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user_by_username(username) do
    Repo.get_by(User, username: username)
  end

  def login(changeset) do
    password_hash = hashpwsalt(changeset.changes.password)
    user = get_user_by_username(changeset.changes.username)
    if validate_pw(user, changeset.changes.password) do
      {:ok, user}
    else
      {:error, changeset}
    end
  end

  def login(username, password) do
    password_hash = hashpwsalt(password)
    user = get_user_by_username(username)
    if validate_pw(user, password) do
      user
    else
      nil
    end
  end

  defp validate_pw(nil, password) do
    dummy_checkpw()
  end
  defp validate_pw(user, password) do
    IO.inspect user
    checkpw(password, user.password_hash)
  end

  def user_changeset() do
    %User{}
    |> cast(%{}, [:username, :email, :password, :password_confirmation])
    |> validate_required([:username, :email, :password, :password_confirmation])
  end

  def login_changeset(params) do
    %User{}
    |> cast(params, [:username, :password])
    |> validate_required([:username, :password])
  end

  def create_user_from_auth(auth, :identity) do
    user = changeset_from_identity(%User{}, %{
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      username: auth.info.nickname,
      password: auth.credentials.other.password,
      password_confirmation: auth.credentials.other.password_confirmation
    })
    Repo.insert(user)
  end
  def create_user_from_auth(auth, provider) do
    user = changeset_from_oauth(%User{}, %{
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      username: auth.info.email,
    })
    Repo.insert(user)
  end

  defp changeset_from_identity(user, params \\ %{}) do
    user
    |> cast(params, ~w(username first_name last_name email password password_confirmation))
    |> validate_required([:username, :email, :password, :password_confirmation])
    |> validate_length(:password, min: 3)
    |> validate_password_confirmation(params)
    |> unique_constraint(:username, name: :unique_usernames)
    |> unique_constraint(:email, name: :unique_emails)
  end

  defp changeset_from_oauth(user, params \\ %{}) do
    IO.inspect user
    IO.inspect params
    user
    |> cast(params, ~w(username first_name last_name email))
    |> validate_required([:username, :email])
    |> unique_constraint(:username, name: :unique_usernames)
    |> unique_constraint(:email, name: :unique_emails)
  end

  defp validate_password_confirmation(changeset, params) do
    case get_change(changeset, :password_confirmation) do
      nil -> changeset
      confirmation ->
        password = get_field(changeset, :password)
        if confirmation == password do
          changeset |> put_change(:password_hash, hashpwsalt(params[:password]))
        else
          password_mismatch_error(changeset)
        end
    end
  end

  defp password_mismatch_error(changeset) do
    add_error(changeset, :password_confirmation, "Passwords does not match")
  end
end

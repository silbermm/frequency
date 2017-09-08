defmodule Frequency.Authentication do
  @moduledoc """
  The boundary for the Authentication system.
  """

  import Ecto.{Query, Changeset}, warn: false
  import Comeonin.Bcrypt, only: [hashpwsalt: 1, checkpw: 2, dummy_checkpw: 0]
  alias Ueberauth.Auth

  alias Frequency.Repo
  alias Frequency.Authentication.User

  @doc """
  Get a user by id
  """
  def get_user(id) do
    Repo.get(User, id)
  end

  @doc """
  Get a user by username
  """
  def get_user_by_username(username) do
    User
    |> by_username(username)
    |> Repo.all
    |> List.first
  end

  @doc """
  Login a user
  """
  def login(changeset) do
    if changeset.valid? do
      password_hash = hashpwsalt(changeset.changes.password)
      user = get_user_by_username(changeset.changes.username)
      if validate_pw(user, changeset.changes.password) do
        {:ok, user}
      else
        {:error, %{changeset | action: :insert}}
      end
    else
      {:error, %{changeset | action: :insert}}
    end
  end

  @doc """
  Changeset for a new user

  Required fields include username, email, password and a password confirmation
  """
  def user_changeset() do
    %User{}
    |> cast(%{}, [:username, :email, :password, :password_confirmation])
    |> validate_required([:username, :email, :password, :password_confirmation])
  end

  @doc """
  Changeset for the login form

  Required fields include username and password
  """
  def login_changeset(params) do
    %User{}
    |> cast(params, [:username, :password])
    |> validate_required([:username, :password])
  end

  def create_user_from_auth(%Auth{provider: :identity} = auth) do
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
  def create_user_from_auth(auth) do
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

  defp by_username(query, username) do
    from u in query,
    where: u.username == ^username,
    select: u
  end

  defp validate_pw(nil, password) do
    dummy_checkpw()
  end
  defp validate_pw(user, password) do
    checkpw(password, user.password_hash)
  end

end

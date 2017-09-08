defmodule Frequency.AuthenticationTest do
  use Frequency.DataCase

  import Comeonin.Bcrypt, only: [hashpwsalt: 1, checkpw: 2, dummy_checkpw: 0]

  alias Frequency.Authentication.User
  alias Frequency.Authentication

  test "getting a user" do
    changeset = %User{username: "silbermm", email: "silbermm@gmail.com"}
    {:ok, user} = Repo.insert(changeset)
    ret_user = Authentication.get_user(user.id)
    assert ret_user.username == user.username
  end

  test "fail to get a user" do
    ret_user = Authentication.get_user(123)
    assert ret_user == nil
  end

  test "get a user by username" do
    changeset = %User{username: "silbermm", email: "silbermm@gmail.com"}
    {:ok, user} = Repo.insert(changeset)
    ret_user = Authentication.get_user_by_username("silbermm")
    assert ret_user.username == user.username
  end

  test "fail to get a user by username" do
    ret_user = Authentication.get_user_by_username("silbermm")
    assert ret_user == nil
  end

  test "login" do
    new_user = %User{username: "silbermm", email: "silbermm@gmail.com", password_hash: password_hash("password")}
    {:ok, user} = Repo.insert(new_user)
    changeset =
      %{username: "silbermm", password: "password"} |> Authentication.login_changeset
    {:ok, user2} = Authentication.login(changeset)
    assert user2.username == "silbermm"
  end

  test "no login" do
    changeset =
      %{username: "silbermm", password: "password"} |> Authentication.login_changeset
    {result, changeset} = Authentication.login(changeset)
    assert result == :error
  end

  defp password_hash(password) do
    hashpwsalt(password)
  end
end

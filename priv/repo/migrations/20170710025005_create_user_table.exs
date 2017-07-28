defmodule Frequency.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :username, :string, unique: true
      add :password_hash, :string, null: false
      add :email, :string, unique: true

      timestamps()
    end
    create unique_index(:users, [:username], name: :unique_usernames)
    create unique_index(:users, [:email], name: :unique_emails)
  end
end

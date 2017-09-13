defmodule Frequency.Repo.Migrations.AddStationsTable do
  use Ecto.Migration

  def change do
    create table(:stations) do
      add :call_letters, :string
      add :channel, :string
      add :website, :string
      add :latitude, :float
      add :longitude, :float

      timestamps()
    end
  end
end

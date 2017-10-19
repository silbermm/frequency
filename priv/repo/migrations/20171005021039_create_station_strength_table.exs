defmodule Frequency.Repo.Migrations.CreateStationStrengthTable do
  use Ecto.Migration

  def change do
    create table(:station_strengths) do
      add :latitude, :float
      add :longitude, :float
      add :strength, :integer
      add :station_id, references(:stations)
      timestamps()
    end
  end
end

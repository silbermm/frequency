defmodule Frequency.Radio.StationStrength do
  use Ecto.Schema
  import Ecto.Changeset

  schema "station_strengths" do
    field :latitude, :float
    field :longitude, :float
    field :strength, :integer
    belongs_to :station, Frequency.Radio.Station

    timestamps()
  end

  def changeset(station_strength, params \\ %{}) do
    station_strength
    |> cast(params, [:latitude, :longitude, :strength])
    |> validate_required([:latitude, :longitude])
  end
end

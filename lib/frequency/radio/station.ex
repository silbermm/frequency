defmodule Frequency.Radio.Station do
  use Ecto.Schema

  schema "stations" do
    field :call_letters, :string
    field :channel, :string
    field :website, :string
    field :latitude, :float
    field :longitude, :float

    has_many :station_strengths, Frequency.Radio.StationStrength

    timestamps()
  end
end

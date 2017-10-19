defmodule Frequency.Radio do
  alias Frequency.Repo
  alias Frequency.Radio.Station
  import Ecto.Changeset

  def stations() do
    Station
    |> Repo.all
    |> Repo.preload(:station_strengths)
  end

  def get_station(station_id) do
    Repo.get(Station, station_id)
  end

  def create_station(changeset) do
    Repo.insert(changeset)
  end

  def station_changeset(params \\ %{}) do
    %Station{}
    |> cast(params, [:call_letters, :channel, :website])
    |> cast_assoc(:station_strengths)
    |> validate_required([:call_letters, :channel])
    |> unique_constraint(:call_letters)
  end
end

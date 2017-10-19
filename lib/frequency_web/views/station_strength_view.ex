defmodule FrequencyWeb.StationStrengthView do
  use FrequencyWeb, :view

  def render("station_strength.json", %{station_strength: station_strength}) do
    %{id: station_strength.id,
      latitude: station_strength.latitude,
      longitude: station_strength.longitude,
      strength: station_strength.strength}
  end
end

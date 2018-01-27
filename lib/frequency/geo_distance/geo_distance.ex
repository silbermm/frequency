defmodule Frequency.GeoDistance do

  @earth_miles 3959

  def calculate(lat1, lon1, lat2, lon2) do
    lat = convert_degrees_to_radians(lat2-lat1)
    lon = convert_degrees_to_radians(lon2-lon1)

    lat1 = convert_degrees_to_radians(lat1)
    lat2 = convert_degrees_to_radians(lat2)

    a = :math.sin(lat/2) * :math.sin(lat/2) + :math.sin(lon/2) * :math.sin(lon/2) * :math.cos(lat1) * :math.cos(lat2)
    c = 2 * :math.atan2(:math.sqrt(a), :math.sqrt(1-a))
    @earth_miles * c
  end

  defp convert_degrees_to_radians(degrees) do
    degrees * :math.pi / 180
  end

end

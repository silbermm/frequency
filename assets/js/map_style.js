const main_color = "#0085a1";
const saturation_value = -25;
const brightness_value = 5;

const style = [
  {
    elementType: "labels",
    stylers: [
      {
        saturation: saturation_value
      }
    ]
  },
  {
    featureType: "poi",
    elementType: "labels",
    stylers: [{ visibility: "off" }]
  },
  {
    featureType: "road.highway",
    elementType: "labels",
    stylers: [{ visibility: "on" }]
  },
  {
    featureType: "road.local",
    elementType: "labels.icon",
    stylers: [{ visibility: "on" }]
  },
  {
    featureType: "road.arterial",
    elementType: "labels.icon",
    stylers: [{ visibility: "off" }]
  },
  {
    featureType: "road",
    elementType: "geometry.stroke",
    stylers: [{ visibility: "off" }]
  },
  {
    featureType: "transit",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "poi",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "poi.government",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "poi.sport_complex",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "poi.attraction",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "poi.business",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "transit",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "transit.station",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "landscape",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "road",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "road.highway",
    elementType: "geometry.fill",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  },
  {
    featureType: "water",
    elementType: "geometry",
    stylers: [
      { hue: main_color },
      { visibility: "on" },
      { lightness: brightness_value },
      { saturation: saturation_value }
    ]
  }
];
export default style;

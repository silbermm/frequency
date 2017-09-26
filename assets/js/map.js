import style from "./map_style";
jQuery(document).ready(function($){
  const d = document.getElementById("map-data");
  if (d != null) {
    const mapData = JSON.parse(d.value);
    console.log(mapData);
  }
  // get the users current latitude / longitude
  if( navigator.geolocation )
  {
    navigator.geolocation.getCurrentPosition( show_map, () => {
      alert("Sorry we can't get your location");
    });
  }
  else
  {
   alert("Sorry, your browser does not support geolocation services.");
  }

  function success(position) {
    position.coords.longitude;
    position.coords.latitude
    var latitude = position.coords.latitude,
        longitude = position.coords.longitude,
        map_zoom = 15;

    var is_internetExplorer11= navigator.userAgent.toLowerCase().indexOf('trident') > -1;

    var main_color = '#0085a1',
        saturation_value= -20,
        brightness_value= 5;
    var style= [ 
      {
              elementType: "labels",
              stylers: [
                        {saturation: saturation_value}
                      ]
            },  
            {
                    featureType: "poi",
                    elementType: "labels",
                    stylers: [
                              {visibility: "off"}
                            ]
                  },
          {
                      featureType: 'road.highway',
                      elementType: 'labels',
                      stylers: [
                                      {visibility: "off"}
                                  ]
                  }, 
          {
                  featureType: "road.local", 
                  elementType: "labels.icon", 
                  stylers: [
                            {visibility: "off"} 
                          ] 
                },
          {
                  featureType: "road.arterial", 
                  elementType: "labels.icon", 
                  stylers: [
                            {visibility: "off"}
                          ] 
                },
          {
                  featureType: "road",
                  elementType: "geometry.stroke",
                  stylers: [
                            {visibility: "off"}
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
    var map_options = {
              center: new google.maps.LatLng(latitude, longitude),
              zoom: map_zoom,
              panControl: false,
              zoomControl: true,
              mapTypeControl: false,
              streetViewControl: false,
              mapTypeId: google.maps.MapTypeId.ROADMAP,
              scrollwheel: false,
              styles: style,
              zoomControlOptions: {
                  style: google.maps.ZoomControlStyle.SMALL,
                  position: google.maps.ControlPosition.BOTTOM_CENTER
                }
          }
    var map = new google.maps.Map(document.getElementById('map'), map_options);
    var marker = new google.maps.Marker({
      position: new google.maps.LatLng(latitude, longitude),
      map: map,
      visible: true
    });
  }
});

const show_map = (position) => {
  const latitude = position.coords.latitude;
  const longitude = position.coords.longitude;
  const map_zoom = 15;

  const is_internetExplorer11 =
    navigator.userAgent.toLowerCase().indexOf("trident") > -1;

  const map_options = {
    center: new google.maps.LatLng(latitude, longitude),
    zoom: map_zoom,
    panControl: false,
    zoomControl: true,
    mapTypeControl: true,
    streetViewControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: false,
    styles: style,
    zoomControlOptions: {
      style: google.maps.ZoomControlStyle.SMALL,
      position: google.maps.ControlPosition.BOTTOM_CENTER
    }
  };
  var map = new google.maps.Map(document.getElementById("map"), map_options);
  var marker = new google.maps.Marker({
    position: new google.maps.LatLng(latitude, longitude),
    map: map,
    visible: true
  });
}
export default show_map;

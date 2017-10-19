import style from "./map_style";
jQuery(document).ready(function($){
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
});

const show_map = (position) => {

  const d = document.getElementById("map-data");
  const mapData = d != null ? JSON.parse(d.value) : [];
  console.log(mapData);

  const latitude = position.coords.latitude;
  const longitude = position.coords.longitude;
  const map_zoom = 15;

  console.log(latitude);
  console.log(longitude);

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

  let groups = groupBy(mapData, "channel");

  console.log(groups);
  for (var f in groups)  {
    const coords = groups[f].map(x => new google.maps.LatLng(x.latitude, x.longitude))

    let polygon = new google.maps.Polygon({
      paths: coords,
      strokeColor: '#FF0000',
      strokeOpacity: 0.8,
      strokeWeight: 3,
      fillColor: '#FF0000',
      fillOpacity: 0.35
    });

    polygon.setMap(map);

  };

}

const groupBy = (xs, key) => {
  return xs.reduce((rv, x) => {
    (rv[x[key]] = rv[x[key]] || []).push(x);
      return rv;
  }, {});
};
export default show_map;

import style from "./map_style";

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

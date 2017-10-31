/*import style from "./map_style";*/
//jQuery(document).ready(function($){
    //// get the users current latitude / longitude
  //if( navigator.geolocation )
  //{
    //navigator.geolocation.getCurrentPosition((position) => {
      //const jwt = document.getElementById("jwt");
      //const myHeaders = new Headers({
        //'authorization': 'Bearer ' + jwt.value,
        //'content-type': 'application/json'
      //});

      //const myInit = { method: 'GET',
                       //headers: myHeaders,
                       //mode: 'cors',
                       //cache: 'default' };
      //fetch('/api/stations', myInit).then( (response) => {
        //return response.text();
      //}).then( (body) => {
        //body = JSON.parse(body);
        //let mapData = body.data;
        //show_map(position, mapData);
      //})

    //}, () => {
      //alert("Sorry we can't get your location");
    //});
  //}
  //else
  //{
   //alert("Sorry, your browser does not support geolocation services.");
  //}
//});

//const show_map = (position, mapData) => {
  //const latitude = position.coords.latitude;
  //const longitude = position.coords.longitude;
  //const map_zoom = 15;

  //const is_internetExplorer11 =
    //navigator.userAgent.toLowerCase().indexOf("trident") > -1;

  //const map_options = {
    //center: new google.maps.LatLng(latitude, longitude),
    //zoom: map_zoom,
    //panControl: false,
    //zoomControl: true,
    //mapTypeControl: true,
    //streetViewControl: false,
    //mapTypeId: google.maps.MapTypeId.ROADMAP,
    //scrollwheel: false,
    //styles: style,
    //zoomControlOptions: {
      //style: google.maps.ZoomControlStyle.SMALL,
      //position: google.maps.ControlPosition.BOTTOM_CENTER
    //}
  //};
  //var map = new google.maps.Map(document.getElementById("map"), map_options);
  //var marker = new google.maps.Marker({
    //position: new google.maps.LatLng(latitude, longitude),
    //map: map,
    //visible: true
  //});

  //mapData.forEach( (f) => {
    //const coords = f.station_strengths.map(x => new google.maps.LatLng(x.latitude, x.longitude))

    //let polygon = new google.maps.Polygon({
      //paths: coords,
      //strokeColor: '#FF0000',
      //strokeOpacity: 0.8,
      //strokeWeight: 3,
      //fillColor: '#FF0000',
      //fillOpacity: 0.35
    //});

    //polygon.setMap(map);
    ////Define position of label
    //var bounds = new google.maps.LatLngBounds();
    //for (var i = 0; i < coords.length; i++) {
      //bounds.extend(coords[i]);
    //}

    //var myLatlng = bounds.getCenter();
    //var mapLabel = new MapLabel({
      //text: mapData.call_letters,
      //position: myLatlng,
      //map: map,
      //fontSize: 20,
      //align: 'left'
    //});

  //});

  //polygon.setMap(map);

/*}*/

//export default show_map;

export var App = {
  loadElm: () => {
    const node = document.getElementById("map");
    const app = Elm.Main.embed(node);

    app.ports.queryLocation.subscribe(arg => {
      navigator.geolocation.getCurrentPosition(position => {
        app.ports.locationResult.send({
          latitude: position.coords.latitude,
          longitude: position.coords.longitude
        });
      });
    });
  }
};

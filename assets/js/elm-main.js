export var App = {
  loadElm: () => {

    var storage  = window.localStorage;
    var node = document.getElementById("main");
    var app = Elm.Main.embed(node);

    app.ports.navigateTo.subscribe( url  => {
      window.location = "/";
    });

    app.ports.addToStorage.subscribe(({jwt: jwt}) => {
      storage.setItem("jwt", jwt);
    });

    app.ports.removeFromStorage.subscribe( key => {
      storage.removeItem(key);
    });

    app.ports.queryStorage.subscribe( key => {
      const jwt = storage.getItem(key);
      if (jwt !== null) 
        app.ports.storageResult.send(jwt);
    });
  }
}

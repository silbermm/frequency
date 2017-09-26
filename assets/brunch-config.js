exports.config = {
  files: {
    javascripts: {
      entryPoints: {
        'js/elm-main.js': 'js/elm-main.js',
        'js/app.js': 'js/app.js',
        'js/map.js': 'js/map.js'
      }
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    watched: ["static", "css", "js", "vendor", "elm"],
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    },
    elmBrunch: {
      mainModules: ["elm/Main.elm", "elm/Map.elm", "elm/Login.elm"],
      makeParameters: ['--debug'],
      executablePath: 'node_modules/elm/binwrappers'
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true
  }
};

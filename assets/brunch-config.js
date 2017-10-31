exports.config = {
  files: {
    javascripts: {
      joinTo: {
        'js/app.js': /^js/,       // all code from 'app/',
        'js/vendor.js': /^(?!js)/ // all BUT app code - 'vendor/', 'node_modules/', etc
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
      mainModules: ["elm/Main.elm", "elm/Map.elm"],
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

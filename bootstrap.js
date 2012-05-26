var bundles = {
    'gigi': {
        'name': 'core',
        'path': ''
    }
};

require(["cs!loader", "cs!utils", "cs!logger"], function(loader) {
    logger.level(App.general.LOG_LEVEL);
    loader.load_module("cs!router",       // Class to load & instantiate
        function(router) { // Run this when class was loaded and instantiated
            Backbone.history.start();
        },
        true,              // Instantiate the router
        App.urls);         // Pass these params to the constructor of Router
});

oldLoad = require.load;
require.load = function (context, moduleName, url) {
    var package = bundles[moduleName];

    if (!package) {
        oldLoad.apply(require, arguments);
        return;
    }

    var url = package.path + '/' + package.name + '.js';
    oldLoad.call(require, context, package.name, url);
};

require(['gigi'], function (gigi) {
    console.log(gigi)
});

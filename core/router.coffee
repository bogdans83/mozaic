define ['cs!module'], (Module) ->
    class Router extends Backbone.Router
        delegateToController: (controller_config, params...) =>
            ###
                Delegates the action of the controller to a specialized class
                which is configured in App.urls.
            ###
            module = "cs!controller/" + controller_config.controller
            layout = "text!" + controller_config.layout

            # Get the last parameter from "params" and filter it according to
            # the allowed_get_params controller configuration.
            get_params = params.pop()
            filtered_params = {}
            # Check if there is a definition of allowed_get_params first.
            # IF THERE IS NONE, ASSUME THAT NO GET PARAMS ARE EXPECTED (!!!)
            if 'allowed_get_params' of controller_config
                for k, v of get_params
                    if k in controller_config.allowed_get_params
                        filtered_params[k] = v
            params.push(filtered_params)

            # First load the dependencies of the given controller, as configured in the app
            dependencies = App.default_loading_modules.concat(controller_config.depends ?= [])
            # Load controller layout
            require( [layout], (raw_template) ->
                ###
                    Load the widgets for the given template
                ###
                logger.info('Loading layout ' + @path)

                loader.load_modules(dependencies, =>
                    # Then, load the controller module itself
                    loader.load_module module, (controller) =>
                        controller.action(params...)
                    , true, controller_config
                )
            )

        constructor: (urls) ->
            ###
                Our router constructor receives a copy of App.urls array,
                parses it and creates a routes array that will get passed
                to the Backbone Router constructor.
            ###
            @urls = urls
            @routes = {}
            @regexp_to_route = {}
            for path, data of urls
                controller = @urls[path].controller
                @routes[path] = "delegateToController"
                regexp = @_routeToRegExp(path)
                @regexp_to_route[regexp] = path
            super({routes: @routes})

        _extractParameters: (route, fragment) ->
            ###
                We override Backbone.Router's parameter extraction method to also
                return the route for which the parameters were extracted to the
                callback function. This allows us to use the same function
                (delegateToController) for multiple urls.
            ###
            result = super(route, fragment)
            path = @regexp_to_route[route]
            result.unshift(@urls[path])
            result
    return Router
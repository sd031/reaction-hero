Package.describe({
  summary: "Reaction Hero - Hero Carousels"
});

Package.on_use(function (api, where) {
  api.use([
    "standard-app-packages",
    "coffeescript",
    "underscore",
    "simple-schema",
    "autoform"
  ], ["client", "server"]);

  api.use([
    "iron-router",
    "less",
    "reaction-core"
  ], ["client"]);

  api.add_files("common/collections.coffee",["client","server"]);
  api.add_files("server/publications.coffee",["server"]);
  api.add_files("server/methods/heros/methods.coffee",["server"]);
  api.add_files([
    "client/subscriptions.coffee",
    "client/routing.coffee",

    "client/templates/hero/manager/manager.html",
    "client/templates/hero/manager/manager.coffee",
    "client/templates/hero/manager/manager.less",

    "client/templates/hero/hero.html",
    "client/templates/hero/hero.coffee",
    "client/templates/hero/hero.less",

    "client/templates/dashboard/widget/widget.html",
    "client/templates/dashboard/widget/widget.coffee",
    "client/templates/dashboard/widget/widget.less",

    "client/templates/addhero/addhero.html",
    "client/templates/addhero/addhero.coffee",
    "client/templates/addhero/addhero.less",

    "client/templates/carousel/carousel.html",
    "client/templates/carousel/carousel.coffee",
    "client/templates/carousel/carousel.less",

  ], ["client"]);
});

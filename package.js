Package.describe({
  summary: "Reaction Hero - dude"
});

Package.on_use(function (api, where) {
  api.use([
    "standard-app-packages",
    "coffeescript"
  ], ["client", "server"]);
  api.use([
    "iron-router",
    "less",
    "reaction-core"
  ], ["client"]);

  api.add_files([
    "client/register.coffee",
    "client/routing.coffee",

    "client/templates/hero/hero.html",
    "client/templates/hero/hero.coffee",
    "client/templates/hero/hero.less",

    "client/templates/dashboard/widget/widget.html",
    "client/templates/dashboard/widget/widget.coffee",
    "client/templates/dashboard/widget/widget.less"

  ], ["client"]);
});

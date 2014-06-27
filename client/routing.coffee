Router.map ->
  @route "hero",
    controller: ShopController
    path: 'dashboard/settings/hero',
    template: 'hero'
    waitOn: ->
      PackagesHandle
  @route "herodemo",
    controller: ShopController
    path: 'hero/demo',
    template: 'herodemo'
    waitOn: ->
      PackagesHandle

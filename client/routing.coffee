Router.map ->
  @route "hero",
    controller: ShopController
    path: '/dashboard/hero',
    template: 'hero'
    waitOn: ->
      PackagesHandle
  @route "herodemo",
    controller: ShopController
    path: '/hero/demo',
    template: 'herodemo'
    waitOn: ->
      PackagesHandle

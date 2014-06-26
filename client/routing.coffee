Router.map ->
  @route "hero",
    controller: ShopController
    path: 'dashboard/settings/hero',
    template: 'hero'
    waitOn: ->
      PackagesHandle

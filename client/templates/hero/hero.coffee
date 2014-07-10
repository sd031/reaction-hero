Template.hero.title = ->
  "Hero Manager"

Template.hero.description = ->
  "Create and manage Hero Carousels for Reaction Commerce."

Template.coreLayout.rendered = ->
  data = Heros.find({placements: IronLocation.path()}).fetch()
  if data
    UI.insert UI.renderWithData(Template.herocarousel, {
        hero: data[0]
    }), $("#main .container-fluid")[0], $(".product-grid")[0]

Router.onAfterAction ->
  data = Heros.find({placements: Router.current().route.name}).fetch()
  if data[0]
    UI.insert UI.renderWithData(Template.herocarousel, {
        hero: data[0]
    }), $("#main .container-fluid")[0], $("#layout-alerts")[0]
  else
    $("#main .container-fluid .carousel").remove()

Template.hero.title = ->
  "Hero Manager"

Template.hero.description = ->
  "Create and manage Hero Carousels for Reaction Commerce."

Template.coreLayout.created = ->

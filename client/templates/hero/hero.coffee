Router.onAfterAction ->
  data = Heros.find({'placements': Router.current()?.route?.name}).fetch()
  if data[0]
    $("#addhero, .hero").remove()
    if $('hero_' + data[0]._id).length == 0
      UI.insert UI.renderWithData(Template.herocarousel, {
          hero: data[0]
      }), $("#main .container-fluid")[0], $("#layout-alerts")[0]
  else
    $("#main .container-fluid .carousel, .carousel.hero, #addhero").remove()
    if Roles.userIsInRole(Meteor.userId(), ['admin']) && (Router.current().route.originalPath.match('\/dashboard\/?') == null)
      UI.insert UI.render(Template.heroadd), $("#main .container-fluid")[0], $("#layout-alerts")[0]

Template.hero.title = ->
  "Hero Manager"

Template.hero.description = ->
  "Create and manage Hero Carousels for Reaction Commerce."

Template.coreLayout.created = ->

Template.heroadd.events
  "click #add-hero-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    $("#heroselect").show()

  "click #heroselect li a": (event, template) ->
    event.preventDefault()
    event.stopPropagation()

    Meteor.call "addHeroToPage", $(event.currentTarget).data('heroidx'), Router.current().route.name, (error) ->
      console.log error if error

    $("#heroselect").hide()

Template.heroadd.helpers
  heros: ->
    return Heros.find().fetch()

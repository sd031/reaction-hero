Template.heroManager.helpers
  heros: ->
    return getHeros()

Template.heroManager.events
  "click #add-hero-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Meteor.call "createHero", (error, productId) ->
      console.log error if error



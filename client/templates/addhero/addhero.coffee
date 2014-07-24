Template.heroadd.events
  "click #add-hero-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()

    Meteor.call "addHeroToPage",  Router.current().route.name, (error, result) ->
      if error
        console.log error
      else
        Session.set 'heroId', result

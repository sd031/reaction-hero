Template.heroManager.rendered = ->

Template.heroManager.helpers
  heros: ->
    return getHeros()

Template.heroManager.events
  "click #add-hero-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Meteor.call "createHero", (error, productId) ->
      console.log error if error

  "click .hero-edit": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Session.set 'selectedHeroIdx', $(event.currentTarget).data('idx')
    $(event.currentTarget).parent().find('.well').toggle()

Template.updateHeroForm.editingDoc = ->
  selectedHeroIdx = Session.get "selectedHeroIdx"
  if selectedHeroIdx
    return Heros.findOne _id: selectedHeroIdx


AutoForm.hooks updateHeroForm:
  onSuccess: (operation, result, template) ->
    Alerts.add "saved.", "success"

  onError: (operation, error, template) ->
    Alerts.add "failed. " + error, "danger"

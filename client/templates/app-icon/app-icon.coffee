Template.heroappicon.events
  "click #add-hero-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()

    Meteor.call "addHeroToPage", (error) ->
      console.log error if error

Template.heroappicon.helpers
  heros: ->
    if img = Media.findOne({'metadata.slideId': this.id})
      return img
    return false


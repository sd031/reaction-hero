Template.herodemo.rendered = ->

Template.herodemo.helpers
  heros: ->
    selector = {}
    return Heros.find(selector).fetch()
  media: ->
    if img = Media.findOne({'metadata.slideId': this.id})
      return img
    return false

Template.herodemo.events

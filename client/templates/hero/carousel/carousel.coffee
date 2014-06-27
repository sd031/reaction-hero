Template.heroPreview.rendered = ->
  _.defer ->
    $('#carousel_cnQWXbh3kRh2wMJZH').carousel()

Template.heroPreview.helpers
  hero: ->
    selector = {}
    return Heros.find(selector).fetch()
  media: ->
    if img = Media.findOne({'metadata.slideId': this.id})
      return img
    return false

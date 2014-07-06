Template.herocarousel.rendered = ->

Template.herocarousel.helpers
  hero: ->
    return Heros.findOne({})
  media: ->
    if img = Media.findOne({'metadata.slideId': this.id})
      return img
    return false

Template.herocarousel.created = ->
  Hero = Heros.findOne({})

  _.defer ->
      # blaze doesnt seem to like indexes with foreach loops
      $('#hero_' + Hero._id + ' .item:first').addClass('active')
      $('#hero_' + Hero._id + ' .carousel-indicators li:first').addClass('active')

      # wire up the carousel
      $('#hero_' + Hero._id).carousel({interval: 5000})

      $('#hero_' + Hero._id + ' .carousel-indicators li').each (idx, val) ->
        $(this).data("data-slide-to": idx).click ->
          $('#hero_' + Hero._id).carousel $(this).data("data-slide-to")
          return

      $('#hero_' + Hero._id + ' a[data-slide="prev"]').click ->
        $('#hero_' + Hero._id).carousel "prev"
        return

      $('#hero_' + Hero._id + ' a[data-slide="next"]').click ->
        $('#hero_' + Hero._id).carousel "next"
        return


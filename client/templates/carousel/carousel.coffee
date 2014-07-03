Template.carousel.rendered = ->

Template.carousel.helpers
  hero: ->
    return Heros.findOne({})
  media: ->
    if img = Media.findOne({'metadata.slideId': this.id})
      return img
    return false

Template.carousel.created = ->
  _.defer ->
      # blaze doesnt seem to like indexes with foreach loops
      $('#carousel .item:first').addClass('active')
      $('#carousel .carousel-indicators li:first').addClass('active')

      # wire up the carousel
      $("#carousel").carousel({interval: 2000})

      $("#carousel .carousel-indicators li").each (idx, val) ->
        $(this).data("data-slide-to": idx).click ->
          $("#carousel").carousel $(this).data("data-slide-to")
          return

      $("#carousel a[data-slide=\"prev\"]").click ->
        $("#carousel").carousel "prev"
        return

      $("#carousel a[data-slide=\"next\"]").click ->
        $("#carousel").carousel "next"
        return


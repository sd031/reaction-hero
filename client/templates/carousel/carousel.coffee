Template.herocarousel.events

  "click .hero-remove-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Meteor.call "deleteHeroFromPage", template.data.hero._id, Router.current().route.name, (error) ->
      console.log error if error

Template.herocarousel.helpers
  media: ->
    if img = Media.findOne({'metadata.slideId': this.id})
      return img
    return false

Template.herocarousel.slideCount = ->
  return (@.slides.length > 1)

Template.herocarousel.created = ->

  _.defer ->
    # blaze doesnt seem to like indexes with foreach loops
    $('.carousel .item:first').addClass('active')
    $('.carousel .carousel-indicators li:first').addClass('active')

    # wire up the carousel
    $('.carousel').carousel({interval: 5000})

    $('.carousel .carousel-indicators li').each (idx, val) ->
      $(this).data("data-slide-to": idx).click ->
        $('.carousel').carousel $(this).data("data-slide-to")
        return

    $('.carousel a[data-slide="prev"]').click ->
      $('.carousel').carousel "prev"
      return

    $('.carousel a[data-slide="next"]').click ->
      $('.carousel').carousel "next"
      return

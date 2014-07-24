Template.herocarousel.events

  "click .hero-remove-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Meteor.call "deleteHero", template.data.hero._id, (error) ->
      console.log error if error

  "click .hero-add-slide-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()

    slide = {
              caption: 'New Slide',
              uri: '/'
              }

    Meteor.call "addHeroSlide", template.data.hero._id, slide, (error) ->
      console.log error if error

  "click .hero-edit-slide-link": (event,template) ->
    event.preventDefault()
    event.stopPropagation()
    $('.edit-slide').show()
    $('.slide-meta, .carousel-indicators').hide()
    $('.hero').carousel('pause')

Template.herocarousel.slideCount = ->
  return (@.slideIds.length)

Template.herocarousel.showChevrons = ->
  return (@.slideIds.length > 1)

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

Template.heroSlide.events
  'submit #slideEditForm': () ->
    $('.edit-slide').hide()
    $('.slide-meta, .carousel-indicators').show()
    $('.hero').carousel('cycle')

Template.heroImageUpload.events
  "click #btn-upload": (event,template) ->
    template.$("#files").click()

  "change #files, dropped #dropzone": (event, template) ->
    heroId = template.data.heroId
    slideId = template.data.slideId
    FS.Utility.eachFile event, (file, heroId, slideId) ->
      fileObj = new FS.File(file)
      fileObj.metadata =
        ownerId: Meteor.userId()
        slideId: template.data.slideId
        shopId: Meteor.app.shopId
      Media.insert fileObj

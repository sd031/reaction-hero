Template.herocarousel.events

  "click .hero-edit": (event,template) ->
    event.preventDefault()
    $('.hero-tools-menu').toggle()

  "click .hero-remove-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    $('.hero-tools-menu').toggle()
    Meteor.call "deleteHero", template.data.hero._id, (error) ->
      console.log error if error

  "click .hero-add-slide-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    $('.hero-tools-menu').toggle()

    slide = {
              caption: 'New Slide',
              uri: '/'
              }

    Meteor.call "addHeroSlide", template.data.hero._id, slide, (error, idx) ->
      console.log error if error
      Session.set "selectedSlide", idx
      Session.set "heroEdit", "true"

  "click .hero-edit-slides-link": (event,template) ->
    event.preventDefault()
    event.stopPropagation()
    $('.hero-tools-menu').toggle()
    $('.hero-slides-edit').show()

Template.herocarousel.rendered = ->
  _.defer ->
    # slide to new slide and show edit form
    edit = Session.get("heroEdit")
    if edit
      idx = Session.get("selectedSlide")
      Session.set "heroEdit", "false"
      $('.hero-tools-menu, .slide-meta, .carousel-indicators, .hero-slides-edit, .carousel-control').hide()
      $('.hero').carousel(($('.carousel-inner .item').length - 1)).carousel('pause')
      $('.item[data-idx="' + idx + '"] .edit-slide').show()


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
    #TODO Move this into a variable setting
    $('.carousel').carousel({interval: 8000})

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

    $(".hero-slides-edit ul").sortable
      items: "> li"
      axis: "x"
      update: (e, ui) ->
        heroId = $(e.target).data('idx')
        uiPositions = $(@).sortable("toArray", attribute:"data-idx")
        Meteor.call "updateHeroSlides", heroId, uiPositions, (error) ->
          console.log error if error

        $(".hero-slides-edit").hide()

Template.heroSlideEdit.helpers
  editingDoc: ->
    HeroSlides.findOne _id: Session.get("selectedSlide")

Template.heroSlideEdit.events
  'click .remove-image': () ->
    console.log "remove image"

  'submit .slideEditForm': (event) ->
    event.preventDefault()
    $('.edit-slide').hide()
    $('.slide-meta, .carousel-indicators, .carousel-control').show()
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
      ReactionCore.Collections.Media.insert fileObj

Template.heroSlideMini.events

  "click .slide-edit-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Session.set("selectedSlide", template.data.slide._id)
    $('.hero-tools-menu, .slide-meta, .carousel-indicators, .hero-slides-edit, .carousel-control').hide()
    $('.hero').carousel($('.slide[data-idx="' + template.data.slide._id + '"').index()).carousel('pause')
    $('.item[data-idx="' + template.data.slide._id + '"] .edit-slide').show()

  "click .slide-remove-link": (event, template) ->
    event.preventDefault()
    Meteor.call "deleteHeroSlide", template.data.heroId, template.data.slide._id, (error) ->
      console.log error if error


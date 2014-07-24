Template.herocarousel.events

  "click .hero-remove-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Meteor.call "deleteHero", template.data.hero._id, (error) ->
      console.log error if error

Template.herocarousel.slideCount = ->
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

Template.heroImageUpload.events
  "click #btn-upload": (event,template) ->
    template.$("#files").click()

  "change #files, dropped #dropzone": (event, template) ->
    selectedHeroSlideId = Session.get "selectedHeroSlideId"
    return unless selectedHeroSlideId
    FS.Utility.eachFile event, (file, selectedHeroIdx, slideIdx) ->
      fileObj = new FS.File(file)
      fileObj.metadata =
        ownerId: Meteor.userId()
        slideId: selectedHeroSlideId
        shopId: Meteor.app.shopId
      Media.insert fileObj

updateSortable = ->
  heroId = Session.get 'selectedHeroId'
  $slides = $(".heroSlides")
  $slides.sortable update: (el) ->

    sortedSlides = _.map($slides.sortable("toArray",
      attribute: "data-idx"
    ), (idx) ->
      return idx
    )

    Meteor.call "updateHeroSlides", heroId, sortedSlides, (error) ->
      console.log error if error

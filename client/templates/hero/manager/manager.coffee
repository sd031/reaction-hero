Template.heroManager.helpers
  heros: ->
    selector = {}
    return Heros.find(selector).fetch()

Template.heroManager.events
  "click #add-hero-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Meteor.call "createHero", (error) ->
      console.log error if error

  "click .hero-edit": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Session.set 'selectedHeroIdx', $(event.currentTarget).data('heroidx')
    $('.well[data-heroidx=' + $(event.currentTarget).data('heroidx') + ']').toggle()

Template.updateHeroForm.heroDoc = ->
  selectedHeroIdx = Session.get "selectedHeroIdx"
  if selectedHeroIdx
    return Heros.findOne _id: selectedHeroIdx

Template.updateHeroForm.helpers
  media: ->
    if img = Media.findOne({'metadata.slideId': this.id})
      return img
    return false

Template.updateHeroForm.events
  "click #add-hero-slide": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    selectedHeroIdx = Session.get "selectedHeroIdx"

    slideTitle = ''
    slideUri = ''
    slide = {title: slideTitle, uri: slideUri}

    if selectedHeroIdx
      Meteor.call "createHeroSlide", selectedHeroIdx, slide, (error, slideId) ->
        console.log error if error

Template.updateHeroForm.rendered = ->

  $slides = $(".heroSlides")
  $slides.sortable
    cursor: "move"
    opacity: 0.3
    placeholder: "sortable"
    forcePlaceholderSize: true
    update: (event, ui) ->

AutoForm.hooks updateHeroForm:
  onSuccess: (operation, result, template) ->
    Alerts.add "saved.", "success"

  onError: (operation, error, template) ->
    Alerts.add "failed. " + error, "danger"

Template.heroImageUpload.events
  "click #btn-upload": (event,template) ->
    $("#files").click()

  "change #files": (event, template) ->
    selectedHeroIdx = Session.get "selectedHeroIdx"
    slideId = template.data.idx
    FS.Utility.eachFile event, (file, selectedHeroIdx, slideIdx) ->
      fileObj = new FS.File(file)
      fileObj.metadata =
        ownerId: Meteor.userId()
        heroId: selectedHeroIdx
        slideId: slideId
        shopId: Meteor.app.shopId
      Media.insert fileObj

  "dropped #dropzone": (event, template) ->
    selectedHeroIdx = Session.get "selectedHeroIdx"
    slideId = template.data.idx
    if selectedHeroIdx
      FS.Utility.eachFile event, (file, selectedHeroIdx, slideIdx) ->
        fileObj = new FS.File(file)
        fileObj.metadata =
          ownerId: Meteor.userId()
          heroId: selectedHeroIdx
          slideId: slideId
          shopId: Meteor.app.shopId
        Media.insert fileObj

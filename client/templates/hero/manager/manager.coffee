Template.heroManager.helpers
  heros: ->
    return Heros.find()
  slides: ->
    return HeroSlides.find()
  selectSlideSchema: ->
    return new SimpleSchema({
      selectedSlideId:
        type: String
    });
  selectSlideOptions: ->
    return HeroSlides.find({}, {sort: {name: 1}}).map (slide) ->
      return { label: slide.name, value: slide._id }
  selectedHeroSlide: ->
    id = Session.get 'selectedHeroSlideId'
    return HeroSlides.findOne(id)
  selectHeroSchema: ->
    return new SimpleSchema({
      selectedHeroId:
        type: String
    });
  selectHeroOptions: ->
    return Heros.find({}, {sort: {name: 1}}).map (hero) ->
      return { label: hero.name, value: hero._id }
  selectedHero: ->
    id = Session.get 'selectedHeroId'
    return Heros.findOne(id)

Template.heroManager.events
  "click #create-hero-slide": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    HeroSlides.insert {}, (error, result) ->
      if error
        console.log error
      else
        Session.set 'selectedHeroSlideId', result

  "click #create-hero": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Heros.insert {}, (error, result) ->
      if error
        console.log error
      else
        Session.set 'selectedHeroId', result

  "change [name=selectedSlideId]": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Session.set 'selectedHeroSlideId', $(event.currentTarget).val()

  "change [name=selectedHeroId]": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    Session.set 'selectedHeroId', $(event.currentTarget).val()

Template.updateSlideForm.helpers
  media: ->
    return Media.findOne({'metadata.slideId': this._id})

Template.updateSlideForm.events
  "click .delete-slide": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    id = $(event.currentTarget).data("slide")
    Meteor.call "deleteHeroSlide", id, (error, result) ->
      console.log error if error

  "click .remove-image": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    @remove()

Template.updateHeroForm.helpers
  addSlideOptions: ->
    return HeroSlides.find({}, {sort: {name: 1}}).map (slide) ->
      return { label: slide.name, value: slide._id }
  addSlideSchema: ->
    return new SimpleSchema({
      addSlideId:
        type: String
    });
  media: (id) ->
    return Media.findOne({'metadata.slideId': id})

Template.updateHeroForm.events
  "click .delete-hero": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    id = $(event.currentTarget).data("hero")
    Heros.remove(id)

  "change [name=addSlideId]": (event, template) ->
    event.preventDefault()
    event.stopPropagation()

    heroId = Session.get 'selectedHeroId'
    slideId = $(event.currentTarget).val()
    console.log slideId

    Meteor.call "addSlideToHero", heroId, slideId, (error, result) ->
      console.log error if error

AutoForm.hooks
  updateHeroForm:
    onSuccess: (operation, result, template) ->
      Alerts.add "saved.", "success"

    onError: (operation, error, template) ->
      Alerts.add "failed. " + error, "danger"
  updateSlideForm:
    onSuccess: (operation, result, template) ->
      Alerts.add "saved.", "success"

    onError: (operation, error, template) ->
      Alerts.add "failed. " + error, "danger"
  selectSlide:
    onSubmit: ->
      return false

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

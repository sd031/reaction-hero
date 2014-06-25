Template.hero.title = ->
  "Hero Manager"

Template.hero.description = ->
  "A Hero Manager for Reaction."

Template.hero.rendered = ->

Template.hero.events = ->

  "dropped #hero-carousel": (event, template) ->
    event.stopImmediatePropagation()
    console.log event
    console.log template

Template.heroUploader.events

  "click #btn-upload": (event,template) ->
    $("#files").click()

  "change #file": (event, template) ->
    console.log event
    console.log template
    ###
    FS.Utility.eachFile event, (file) ->
      fileObj = new FS.File(file)
      fileObj.metadata =
        ownerId: Meteor.userId()
        shopId: Meteor.app.shopId
      Media.insert fileObj
    ###

  "dropped #dropzone": (event, template) ->
    console.log event
    console.log template
    ###
    FS.Utility.eachFile event, (file) ->
      fileObj = new FS.File(file)
      fileObj.metadata =
        ownerId: Meteor.userId()
        shopId: Meteor.app.shopId
      Media.insert fileObj
    ###

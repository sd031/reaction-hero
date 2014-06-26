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

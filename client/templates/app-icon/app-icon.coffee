Template.userDropdown.rendered = ->
  ###
  Insert the App Icon to add a hero into the User Dropdown
  ###
  unless Roles.userIsInRole(Meteor.userId(), ['admin'])
    return false
  UI.insert UI.render(Template.heroappicon), $(".user-accounts-dropdown-apps")[0]

Template.heroappicon.events
  "click #add-hero-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()
    $("#heroselect").show()

  "click #heroselect li a": (event, template) ->
    event.preventDefault()
    event.stopPropagation()

    Meteor.call "addHeroToPage", $(event.currentTarget).data('heroidx'), Router.current().route.name, (error) ->
      console.log error if error

    $("#heroselect").hide()

Template.heroappicon.helpers
  heros: ->
    return Heros.find().fetch()

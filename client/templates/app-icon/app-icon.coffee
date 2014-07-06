###
Insert the App Icon to add a hero into the User Dropdown
###
Template.userDropdown.rendered = ->
  unless Roles.userIsInRole(Meteor.userId(), ['admin'])
    return false
  UI.insert UI.render(Template.heroappicon), $(".user-accounts-dropdown-apps")[0]

Template.heroappicon.events
  "click #add-hero-link": (event, template) ->
    event.preventDefault()
    event.stopPropagation()

    Meteor.call "addHeroToPage", (error) ->
      console.log error if error

Template.heroappicon.helpers
  heros: ->
    if img = Media.findOne({'metadata.slideId': this.id})
      return img
    return false


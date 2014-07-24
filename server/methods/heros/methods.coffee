Meteor.methods

  ###
  # addHeroToPage
  ###
  addHeroToPage: (page) ->
    # only admins can add a hero to the page
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.insert {placements: [page]}, (error, result) ->
      if error
        console.log error

  ###
  #
  ###
  deleteHero: (heroId) ->
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.remove heroId, (error, result) ->
      if error
        console.log error


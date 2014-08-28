Meteor.methods

  ###
  # addHeroToPage
  ###
  addHeroToPage: (page) ->
    # only admins can add a hero to the page
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.insert {placements: [page]}, (error, heroId) ->
      if !error and heroId

        slide = {
                  caption: 'New Slide',
                  uri: '/'
                  }

        HeroSlides.insert slide, (error, slideId) ->
          if !error and slideId
            Heros.update({_id: heroId}, {$addToSet:{"slideIds": slideId}})


  ###
  # deleteHero
  ###
  deleteHero: (heroId) ->
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.remove heroId, (error, result) ->
      if error
        console.log error

  ###
  # addHeroSlide
  ###
  addHeroSlide: (heroId, slide) ->
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    HeroSlides.insert slide, (error, slideId) ->
      if !error and slideId
        Heros.update({_id: heroId}, {$addToSet:{"slideIds": slideId}})

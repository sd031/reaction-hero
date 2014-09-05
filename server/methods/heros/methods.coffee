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

    slides = Heros.find({_id: heroId})
    Heros.remove heroId, (error, result) ->
      if error
        console.log error

    HeroSlides.remove slides, (error, result) ->

  ###
  # addHeroSlide
  ###
  addHeroSlide: (heroId, slide) ->
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    HeroSlides.insert slide, (error, slideId) ->
      if !error and slideId
        Heros.update({_id: heroId}, {$addToSet:{"slideIds": slideId}})


  ###
  # updateHeroSlides
  ###
  updateHeroSlides: (heroId, slides) ->
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.update({_id: heroId}, {$set:{"slideIds": slides}})

  ###
  # deleteHeroSlide
  ###
  deleteHeroSlide: (heroId, slideId) ->
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.update({_id: heroId}, {$pull: {'slideIds': {$in: [slideId]}}})
    HeroSlides.remove({_id: slideId})


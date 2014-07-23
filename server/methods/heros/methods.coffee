Meteor.methods

  ###
  # deleteHeroSlide
  ###
  deleteHeroSlide: (slideId) ->
    # only admins can delete hero slides
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    HeroSlides.remove slideId, (error, result) ->
      unless error
        Heros.update({slides: slideId}, {$pull:{slides: slideId}}, {multi: true})

  ###
  # addHeroToPage
  ###
  addHeroToPage: (heroId, page) ->
    # only admins can add a hero to the page
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.update({_id: heroId}, {$addToSet:{"placements": page}})

  ###
  # deleteHeroFromPage
  ###
  deleteHeroFromPage: (heroId, page) ->
    # only admins can remove hero from the page
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.update(heroId, {$pull:{"placements": page}})

  ###
  # addSlideToHero
  ###
  addSlideToHero: (heroId, slideId) ->
    # only admins add slides to hero
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.update({_id: heroId}, {$addToSet:{"slides": slideId}})

  ###
  # updateHeroSlides
  ###
  updateHeroSlides: (heroId, slides) ->
    # only admins add slides to hero
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.update({_id: heroId}, {$set:{"slides": slides}})


Meteor.methods
  ###
  # createHero
  #
  # Create a new Hero Carousel
  ###
  createHero: (heroName) ->
    # only admins can create heros
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    heroId = Heros._collection.insert({
                              _id: Random.id()
                              name: "Test Hero"
                              shopId: Meteor.app.getCurrentShop()._id
                              slides: []
                            })

  ###
  # createHeroSlide
  #
  # Create a new slide for an existing Hero Carousel
  ###
  createHeroSlide: (heroId, slide) ->
    # only admins can create hero slides
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false


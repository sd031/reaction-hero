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

    count = Heros.find().count() + 1
    heroId = Heros._collection.insert({
                              _id: Random.id()
                              name: "Hero " + count
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

    slide.id = Random.id()
    Heros.update(heroId, {$addToSet:{"slides": slide}})

  ###
  # updateHeroSlide
  ###
  updateHeroSlide: (heroId, slide) ->
    # only admins can update hero slides
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.update(
        {
            _id: heroId,
            "slides.id": slide.id
        },
        {
            $set:
                {
                    "slides.$.title": slide.title,
                    "slides.$.uri": slide.uri
                }
        }
    )

  ###
  # updateHeroSlides
  ###
  updateHeroSlides: (heroId, slides) ->
    # only admins can update hero slides
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.update({"_id":heroId}, {$set:{"slides": slides}}, {validate: false}, (error,result) ->
      console.log error if error
      return
    )

  ###
  # deleteHeroSlide
  ###
  deleteHeroSlide: (heroId, slide) ->
    # only admins can delete hero slides
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false
    Heros.update(heroId, {$pull:{"slides": {id: slide}}})

  ###
  # addHeroToPage
  ###
  addHeroToPage: (heroId, page) ->
    # only admins can add a hero to the page
    unless Roles.userIsInRole(Meteor.userId(), ['admin'])
      return false

    Heros.update({_id: heroId}, {$addToSet:{"placements": page}})

###
# HeroSlides
###
ReactionCore.Schemas.HeroSlides = new SimpleSchema
  shopId:
    type: String
    autoValue: ->
      if this.isInsert
        return Meteor.app.shopId or "1" if Meteor.isClient
        # force the correct value upon insert
        return Meteor.app.getShopId()
      else
        # don't allow updates
        this.unset()
  uri:
    type: String
    label: "URI"
    defaultValue: ''
  caption:
    type: String
    label: "caption"
    defaultValue: ''
  createdAt:
    type: Date
    optional: true
    autoValue: ->
      if this.isInsert
        # force the correct value upon insert
        return new Date
      else
        # don't allow updates
        this.unset()
  updatedAt:
    type: Date
    optional: true
    autoValue: ->
      if this.isInsert
        # don't allow inserts
        this.unset()
      else
        # force the correct value every time we update
        return new Date

ReactionCore.Collections.HeroSlides = HeroSlides = @HeroSlides = new Meteor.Collection "HeroSlides"
ReactionCore.Collections.HeroSlides.attachSchema ReactionCore.Schemas.HeroSlides

HeroSlides.helpers
  image: ->
    ReactionCore.Collections.Media.findOne 'metadata.slideId': this._id

###
# Heros
###
ReactionCore.Schemas.Heros = new SimpleSchema
  shopId:
    type: String
    autoValue: ->
      if this.isInsert
        return Meteor.app.shopId or "1" if Meteor.isClient
        # force the correct value upon insert
        return Meteor.app.getShopId()
      else
        # don't allow updates
        this.unset()
  isVisible:
    type: Boolean
    defaultValue: false
  createdAt:
    type: Date
    optional: true
    autoValue: ->
      if this.isInsert
        # force the correct value upon insert
        return new Date
      else
        # don't allow updates
        this.unset()
  updatedAt:
    type: Date
    optional: true
    autoValue: ->
      if this.isInsert
        # don't allow inserts
        this.unset()
      else
        # force the correct value every time we update
        return new Date
  placements:
    type: [String]
    defaultValue: []
  slideIds:
    type: [String]
    defaultValue: []

ReactionCore.Collections.Heros = Heros = @Heros = new Meteor.Collection "Heros"
ReactionCore.Collections.Heros.attachSchema ReactionCore.Schemas.Heros

Heros.helpers
  slides: ->
    return _.map this.slideIds, (id) ->
      return HeroSlides.findOne id

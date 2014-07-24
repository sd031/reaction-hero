@HeroSlides = new Meteor.Collection 'HeroSlides',
  schema:
    shopId:
      type: String
      autoValue: ->
        if this.isInsert
          return Meteor.app.shopId or "1" if Meteor.isClient
          # force the correct value upon insert
          return Meteor.app.getShopId()
        else
          # don't allow updates
          this.unset();
    uri:
      type: String
      optional: true,
      label: "URI"
    title:
      type: String
      optional: true
    createdAt:
      type: Date
      optional: true
      autoValue: ->
        if this.isInsert
          # force the correct value upon insert
          return new Date
        else
          # don't allow updates
          this.unset();
    updatedAt:
      type: Date
      optional: true
      autoValue: ->
        if this.isInsert
          # don't allow inserts
          this.unset();
        else
          # force the correct value every time we update
          return new Date

HeroSlides = @HeroSlides

HeroSlides.helpers
  image: ->
    Media.findOne 'metadata.slideId': this._id

@Heros = new Meteor.Collection 'Heros',
  schema:
    shopId:
      type: String
      autoValue: ->
        if this.isInsert
          return Meteor.app.shopId or "1" if Meteor.isClient
          # force the correct value upon insert
          return Meteor.app.getShopId()
        else
          # don't allow updates
          this.unset();
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
          this.unset();
    updatedAt:
      type: Date
      optional: true
      autoValue: ->
        if this.isInsert
          # don't allow inserts
          this.unset();
        else
          # force the correct value every time we update
          return new Date
    placements:
      type: [String]
      defaultValue: []
    slideIds:
      type: [String]
      defaultValue: []

Heros = @Heros

Heros.helpers
  slides: ->
    return _.map this.slideIds, (id) ->
      return HeroSlides.findOne id

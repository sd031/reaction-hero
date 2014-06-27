HeroSlideSchema = new SimpleSchema
  uri:
    type: String
  title:
    type: String

@Heros = new Meteor.Collection 'Heros',
  schema:
    shopId:
      type: String
    name:
      type: String
    slides:
      type: [HeroSlideSchema]
      optional: true

Heros = @Heros

###
# Fixture - we always want a record
###
Meteor.startup ->
  unless Packages.findOne({name:"reaction-hero"})
    Shops.find().forEach (shop) ->
      Packages.insert
        shopId: shop._id
        name: "reaction-hero"

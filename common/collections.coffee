@HeroSlideSchema = new SimpleSchema
  id:
    type: String
    optional: true
  uri:
    type: String
  title:
    type: String
  assetId:
    type: String
    optional: true

HeroSlideSchema = @HeroSlideSchema

@Heros = new Meteor.Collection 'Heros',
  schema:
    shopId:
      type: String
    name:
      type: String
    createdAt:
      type: Date
      optional: true
    updatedAt:
      type: Date
      optional: true
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

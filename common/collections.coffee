@HeroSchema = new SimpleSchema([
  PackageConfigSchema
  {
    gallery:
      type: Object
      optional: true
  }
])

###
# Fixture - we always want a record
###
Meteor.startup ->
  unless Packages.findOne({name:"reaction-hero"})
    Shops.find().forEach (shop) ->
      Packages.insert
        shopId: shop._id
        name: "reaction-hero"
        gallery: {test: true}

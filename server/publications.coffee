Meteor.publish "Heros", ->
  shop = Meteor.app.getCurrentShop(this)
  if shop
    Heros.find
      shopId: shop._id
  else
    []

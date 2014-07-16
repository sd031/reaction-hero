Meteor.publish "Heros", ->
  shopId = Meteor.app.getShopId(this)
  if shopId
    Heros.find
      shopId: shopId
  else
    []

Meteor.publish "HeroSlides", ->
  shopId = Meteor.app.getShopId(this)
  if shopId
    HeroSlides.find
      shopId: shopId
  else
    []

adminOnly = (userId) ->
  unless Roles.userIsInRole(userId, ['admin'])
    return false
  return true

Heros.allow
  insert: adminOnly
  update: adminOnly
  remove: adminOnly

HeroSlides.allow
  insert: adminOnly
  update: adminOnly
  remove: adminOnly
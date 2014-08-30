Heros = ReactionCore.Collections.Heros
HeroSlides = ReactionCore.Collections.HeroSlides

Meteor.publish "Heros", ->
  shopId = ReactionCore.getShopId(this)
  if shopId
    return Heros.find
            shopId: shopId
  else
    []

Meteor.publish "HeroSlides", ->
  shopId = ReactionCore.getShopId(this)
  if shopId
    return HeroSlides.find
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

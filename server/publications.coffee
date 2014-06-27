Meteor.publish "Heros", ->
  shop = Meteor.app.getCurrentShop(this)
  if shop
    Heros.find
      shopId: shop._id
  else
    []

Heros.allow
  insert: (userId, doc) ->
    unless Roles.userIsInRole(userId, ['admin'])
      return false
    true
  update: (userId, doc, fields, modifier) ->
    unless Roles.userIsInRole(userId, ['admin'])
      return false
    true
  remove: (userId, doc) ->
    unless Roles.userIsInRole(userId, ['admin'])
      return false
    true

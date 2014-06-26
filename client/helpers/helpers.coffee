@getHeros = ->
  selector = {}
  return Heros.find(selector).fetch()

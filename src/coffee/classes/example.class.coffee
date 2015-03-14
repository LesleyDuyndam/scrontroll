###
  EXAMPLE Class
###

class TRACKER
  constructor: () ->
    @subscribers = []

  broadcast: () ->
#    Run all the callbacks

  subscribe: ( callback ) ->
    @subscribers.push( callback )
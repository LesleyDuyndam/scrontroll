root = exports ? this

###

  direction() factory

  Gets the current and previous event as a argument. It calculates the scroll direction
  and returns the results as an object.

  returns {
   y : atTop || up || atBottom || down
   x : atLeft || left || atRight || right

###

root.direction = ( this_event, prev_event ) ->

  defaults =
    'y' : 'atTop'
    'x' : 'atLeft'

  ###

    If the event got triggered for the first time, there is no previous event to calculate
    with. Return the defaults instead.

  ###
  return defaults if prev_event is undefined

# Calculate the Scroll directions
  return {
  'y': if this_event.y >= prev_event.y then 'down' else 'up'
  'x': if this_event.x >= prev_event.x then 'right' else 'left'
  }

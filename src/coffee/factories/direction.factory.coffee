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

  return defaults if prev_event is undefined

# Return the calculatet the Scroll directions
  'y': if this_event.y >= prev_event.y then 'down' else 'up'
  'x': if this_event.x >= prev_event.x then 'right' else 'left'

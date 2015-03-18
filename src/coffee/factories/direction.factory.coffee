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
    'y'         : 'atTop'
    'x'         : 'atLeft'
    'yChanged'  : true
    'xChanged'  : true

  return defaults if prev_event is undefined

#  if( event_id is 0 || @index[ event_id ].direction.y != @index[ event_id - 1 ].direction.y )

# Return the calculatet the Scroll directions
  'y'         : if this_event.y >= prev_event.y then 'down' else 'up'
  'x'         : if this_event.x >= prev_event.x then 'right' else 'left'
  'yChanged'  : if this_event.y isnt prev_event.y then true else false
  'xChanged'  : if this_event.x isnt prev_event.x then true else false
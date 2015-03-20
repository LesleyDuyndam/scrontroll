root = exports ? this

###

  Speed factory


  Gets the current and previous event as a argument. It calculates the scroll speed per second
  and returns the results as an object { x: int, y: int }.

  int = PPS ( Pixels per Second )

  returns { x: int, y: int }

###

root.speed = ( this_event, prev_event ) ->

  defaults =
    'y' : 0
    'x' : 0

  return defaults if prev_event is undefined

# Calculate the time between the two events
  time = this_event.timeStamp - prev_event.timeStamp

  # Return the calculated Scroll directions ( x & y )
  'y': ( Math.abs( this_event.y - prev_event.x ) / time ) * 1000
  'x': ( Math.abs( this_event.x - prev_event.x ) / time ) * 1000
root = exports ? this

###

  direction factory

  Gets the current and previous event as a argument. It calculates the scroll direction
  and returns the results as an object.

  returns {
   y : atTop || up || atBottom || down
   x : atLeft || left || atRight || right

###

root.speed = ( this_event, prev_event ) ->

  defaults =
    'y' : 0
    'x' : 0

  return defaults if prev_event is undefined

# Calculate the time between the two events
  time = this_event.timeStamp - prev_event.timeStamp

# Return the calculated PPS (Pixels Per Seconds)
  'y': ( Math.abs( this_event.y - prev_event.x ) / time ) * 1000
  'x': ( Math.abs( this_event.x - prev_event.x ) / time ) * 1000

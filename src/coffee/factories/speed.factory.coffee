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

  ###

    If the event got triggered for the first time, there is no previous event to calculate
    with. Return the defaults instead.

  ###
  return defaults if prev_event is undefined

# Calculate the time between the two events
  time = this_event.timeStamp - prev_event.timeStamp

# Calculate the scrolled distance between the two events and convert negative values to positives.
  distance = {
    'y' : Math.abs( this_event.y - prev_event.x )
    'x' : Math.abs( this_event.x - prev_event.x )
  }

# Calculate the PPS (Pixels Per Seconds) and return as a OBJECT
  return {
  'y': ( distance.y / time ) * 1000
  'x': ( distance.x / time ) * 1000
  }
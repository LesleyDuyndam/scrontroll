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






###

  Average speed factory


  Gets the complete event array. It calculates the average scroll speed per second
  and returns the results as an object { x: int, y: int }.

  int = PPS ( Pixels per Second )

  returns { x: int, y: int }

###
root.average_speed = ( event_index, max_decimals ) ->

  max_decimals = if max_decimals != undefined then parseInt( max_decimals ) else 3

  console.dir event_index

  buffer =
    x : 0
    y : 0

  # Calculate the sum of all event speeds ( x & y )
  for event in event_index
    do ( event ) ->
      buffer.y += event.speed.y
      buffer.x += event.speed.x


  # Return the calculated average speed with a value of max 3 decimals
  if( max_decimals )
    y : parseFloat( ( buffer.y / event_index.length ).toFixed( max_decimals ) )
    x : parseFloat( ( buffer.x / event_index.length ).toFixed( max_decimals ) )
  else
    y : parseInt buffer.y / event_index.length
    x : parseInt buffer.x / event_index.length
root = exports ? this

###

  Average speed factory


  Gets the complete event array. It calculates the average scroll speed per second
  and returns the results as an object { x: int, y: int }.

  int = PPS ( Pixels per Second )

  returns { x: int, y: int }

###
root.average_speed = ( event_index, max_decimals ) ->

  max_decimals = if max_decimals != undefined then parseInt( max_decimals ) else 3

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
    y : parseFloat ( buffer.y / event_index.length ).toFixed( max_decimals )
    x : parseFloat ( buffer.x / event_index.length ).toFixed( max_decimals )
  else
    y : parseInt buffer.y / event_index.length
    x : parseInt buffer.x / event_index.length
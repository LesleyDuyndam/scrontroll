# give vertical direction STRING as argument

horizontal_direction_composer = ( this_event, prev_event, callback ) ->

  direction = root.direction( this_event, prev_event )

  if( direction.xChanged )
    callback direction.x

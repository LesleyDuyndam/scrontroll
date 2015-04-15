
root.direction_composer = ( name, index, event_id, callback ) ->

  console.log '@index = '
  console.dir @index

  this_event = index[ event_id ]
  prev_event = index[ event_id - 1 ]


  direction = root.direction( this_event, prev_event )

  if( direction.xChanged or direction.yChanged  )
    if name is 'direction'
      this_event.direction = direction
      callback( name, this_event )

    if direction.xChanged
      if name is 'horizontal-direction'
        callback( name, direction.x )

    if direction.yChanged
      if name is 'vertical-direction'
        callback( name, direction.y )

root.speed_composer = ( name, this_event, prev_event, callback ) ->

  #   Calculate the speed and store the output in the @index[ this_event ]

  this_event.speed = root.speed this_event, prev_event

  if name is 'average-speed'
    callback name, root.speed

  #   Broadcast the calculation right away, as there is no point in saving every average at this moment
  #   @todo: Should the average speed be stored in the @index[]?
  if @channelExist( 'average-speed' )
    @broadcast 'average-speed', root.average_speed @index















root.direction_composer = ( name, this_event, prev_event, callback ) ->

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
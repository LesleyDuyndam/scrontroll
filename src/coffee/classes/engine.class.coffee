root = exports ? this

###

  ENGINE Class
  extends TRACKER class

###

class root.ENGINE extends root.TRACKER
  constructor: () ->
    super

#   Ask tracker to be notified when scroll event is triggered and execute @supervisor
    @subscribe 'tracker', @router




  ###

    @router() | Run tasks

    - Delegates input to the factories
    - Adds factory output to event in the @index[]
    - Broadcast event key when done, so subscribers know something changed


  ###
  router: ( event_id ) =>

    this_event = @index[ event_id ]
    prev_event = @index[ event_id - 1 ]

    direction = undefined

    # give direction OBJECT as argument
    if @channelExist( 'direction' )
      if direction is undefined
        direction = root.direction( this_event, prev_event )

      if( direction.xChanged or direction.yChanged  )
          this_event.direction = direction
          @broadcast 'direction', this_event

    # give vertical direction STRING as argument
    if @channelExist( 'horizontal-direction' )
      if direction is undefined
        direction = root.direction( this_event, prev_event )

      if( direction.xChanged )
        @broadcast 'horizontal-direction', direction.x

    # give horizontal direction STRING as argument
    if @channelExist( 'vertical-direction' )
      if direction is undefined
        direction = root.direction( this_event, prev_event )

      if( direction.yChanged )
        @broadcast 'vertical-direction', direction.y




#   Calculate the speed and store the output in the @index[ this_event ]
    if @channelExist( 'speed' )
      this_event.speed = root.speed this_event, prev_event
      @broadcast 'speed', this_event

#   Broadcast the calculation right away, as there is no point in saving every average at this moment
#   @todo: Should the average speed be stored in the @index[]?
    if @channelExist( 'average_speed' )
      @broadcast 'average_speed', root.average_speed @index

#   Return the current event_id
    event_id
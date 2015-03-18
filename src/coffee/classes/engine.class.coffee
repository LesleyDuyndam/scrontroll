root = exports ? this

###

  ENGINE Class
  extends TRACKER class
  
  Receives new input on scroll event from the TRACKER


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




#   Calculate the direction and store the output in the @index[ this_event ]
    if (
      @channelExist( 'direction' ) or
      @channelExist( 'vertical-direction' ) or
      @channelExist( 'horizontal-direction' )
    )
      this_event.direction = root.direction( this_event, prev_event )

      # give direction OBJECT as argument
      if @channelExist( 'direction' )
        if( this_event.direction.xChanged or this_event.direction.yChanged  )
          @broadcast 'direction', this_event

        # give vertical direction STRING as argument
        if @channelExist( 'horizontal-direction' )
          if( this_event.direction.xChanged )
            @broadcast 'horizontal-direction', this_event.direction.x

        # give horizontal direction STRING as argument
        if @channelExist( 'vertical-direction' )
          if( this_event.direction.yChanged )
            @broadcast 'vertical-direction', this_event.direction.y




#   Calculate the speed and store the output in the @index[ this_event ]
    if @channel[ 'speed' ] isnt undefined
      this_event.speed = root.speed this_event, prev_event

      if this_event.speed > 0
        @broadcast 'speed', this_event

#   Return the current event_id
    event_id
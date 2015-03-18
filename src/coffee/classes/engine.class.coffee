root = exports ? this

###

  ENGINE Class
  extends TRACKER class
  
  Receives new input on scroll event from the TRACKER


###

class root.ENGINE extends root.TRACKER
  constructor: () ->
    super

    #    Add a new channel to broadcast to
    @addChannel 'engine'

#   Ask tracker to be notified when scroll event is triggered and execute @supervisor
    @subscribe 'tracker', @supervisor




  ###

    @supervisor() | Run tasks

    - Delegates input to the factories
    - Adds factory output to event in the @index[]
    - Broadcast event key when done, so subscribers know something changed


  ###
  supervisor: ( event_id ) =>

#   Declare the current and previous events so the factories can process the data
    this_event = @index[ event_id ]
    prev_event = @index[ event_id - 1 ]


#   Calculate the direction and store the output in the @index[ this_event ]
    this_event.direction = root.direction( this_event, prev_event )

#   Calculate the speed and store the output in the @index[ this_event ]
    this_event.speed = root.speed( this_event, prev_event )

#   Notify the engine subscribers that a new event has been triggered and manipulated
    @broadcast 'engine', event_id

#   Return the current event_id
    event_id
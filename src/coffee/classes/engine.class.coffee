###
  PROCESSOR Class
  extends TRACKER class

  Receives new input from the TRACKER and processes it to usable data
###

class ENGINE extends TRACKER
  constructor: () ->
    super
    @subscribers.engine = []

    @subscribe 'tracker', @supervisor


  calc_direction: ( event_key ) ->

    defaults =
      'x' : 'down'
      'y' : 'right'

    return defaults if event_key is 0

    last_event = @index[ event_key - 1 ]
    this_event = @index[ event_key ]

#    Scroll directions
    return {
      'x': if this_event.x >= last_event.x then 'down' else 'up',
      'y': if this_event.y >= last_event.y then 'right' else 'left'
    }

  calc_speed: ( event_key ) ->

    defaults =
      'x' : 0
      'y' : 0

    return defaults if event_key is 0

    last_event = @index[ event_key - 1 ]
    this_event = @index[ event_key ]

    time = this_event.timeStamp - last_event.timeStamp

    distance = {
      'x' : Math.abs( this_event.x - last_event.x )
      'y' : Math.abs( this_event.y - last_event.x )
    }

#    Pixels per seconds
    return {
      'x': ( distance.x / time ) * 1000
      'y': ( distance.y / time ) * 1000
    }


  supervisor: ( event_key ) =>
    @index[ event_key ].direction = @calc_direction( event_key )
    @index[ event_key ].speed = @calc_speed( event_key )

    @broadcast 'engine', event_key
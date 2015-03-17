###
  PROCESSOR Class
  extends TRACKER class

  Receives new input from the TRACKER and processes it to usable data
###

class ENGINE extends TRACKER
  constructor: () ->
    super
    @subscribers.processor = []

    @subscribe 'tracker', @supervisor


  calc_direction: ( event_key ) ->

    return false if event_key is 0

    last_event = @index[ event_key - 1 ]
    this_event = @index[ event_key ]

#    Scroll directions
    return {
      'x': if this_event.x >= last_event.x then 'down' else 'up',
      'y': if this_event.y >= last_event.y then 'right' else 'left'
    }

  calc_speed: ( event_key ) ->

    return false if event_key is 0

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
#    console.dir @index

#    Push new scroll event to index
#    @current_key = @index.push( event ) - 1
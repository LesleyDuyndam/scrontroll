###
  PROCESSOR Class
  extends TRACKER class

  Receives new input from the TRACKER and processes it to usable data
###

class SCRONTROLL extends ENGINE
  constructor: () ->
    super
    @subscribers.direction = []

    watcher = ( event_key ) =>
      console.dir @index[ event_key ]

      if( event_key is 0 or @index[ event_key ].direction.x != @index[ event_key - 1 ].direction.x )
        @broadcast 'direction', @index[ event_key ].direction.x

    @subscribe 'engine', watcher



  watch: ( name, callback ) =>
    @subscribe( name, callback )











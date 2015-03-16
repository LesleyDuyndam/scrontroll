###
  PROCESSOR Class
  extends TRACKER class

  Receives new input from the TRACKER and processes it to usable data
###

class PROCESSOR extends TRACKER
  constructor: () ->
    @index = []

    super
    @subscribers.processor = []

    @subscribe 'tracker', ( event ) =>

      key = @index.push( event ) - 1

      @broadcast( 'processor', @index[ key ] )
root = exports ? this

###

  SCRONTROLL Class
  extends ENGINE class

  SCRONTROLL
    - receives a notification from the 'engine' when a new event has been triggered and processed.

###

class root.SCRONTROLL extends root.ENGINE
  constructor: () ->
    super
    @addChannel 'direction'


#   Ask 'engine' to notify when it received a new event and is done processing the data.
#   Run the @watcher( event_id ) on notification
    @subscribe 'engine', @controller




  ###

     @controller() | Check conditions and broadcast changes if needed

     arguments
       event_id = String

     returns
       event_id = String || FALSE = boolean

   ###

  controller: ( event_id ) =>
    if( event_id is 0 or @index[ event_id ].direction.y != @index[ event_id - 1 ].direction.y )

#      Direction changed, broadcast new direction to watcher
      @broadcast 'direction', @index[ event_id ].direction.y

      return @index[ event_id ].direction.y

#    Direction did not change, do nothing and return false
    return false




  ###

    @watch() | Extend the @subscribe() method to a usable API Method.

    The function you pass as the second argument will be called every time the subscribed
    event ( name ) gets broadcasted by the controller.
  
    

    arguments
      name = 'String'
      callback = function( data )

    returns
      callback_id = 'Int'

  ###

  watch: ( name, callback ) =>
    @subscribe( name, callback )
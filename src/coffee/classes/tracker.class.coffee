###
  TRACKER Class

  1. Registers the scroll callbacks
  2. Start/ Stop tracking
  3. Call callbacks on event

  arguments = {
    autostart: boolean
  }
###

class TRACKER
  constructor: ( @options ) ->



#    Include the window object into the class
    @window = $( window )
    console.dir @window


#    Register if Tracker is hooked to scroll event
    @active = false



#    Store the registered scroll callbacks
    @subscribers = []




#    Count the amount of times scroll event is triggered
    @counter = 0


#   Set active to true (autostart), if not explicitly turned on
    if @options.autostart is undefined or @options.autostart is true
      @start()



#  Start tracking scroll events
  start: () ->
    @window.scroll ( event ) =>
      @broadcast( event )

    @active = true


#  Stop tracking scroll events
  stop: () ->
    @window.off( 'scroll' )
    @active = false


  trigger: () ->
    @window.trigger( 'scroll' )


# Add subscribers callback function to call on broadcast
  subscribe: ( callback ) ->
    @subscribers.push( callback )



#  Broadcast scroll event to subscribers
  broadcast: ( event ) ->
    @counter++
    for callback in @subscribers
      callback( event )
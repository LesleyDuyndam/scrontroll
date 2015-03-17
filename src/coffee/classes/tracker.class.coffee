root = exports ? this

###

  TRACKER Class

  1. TRACKER | receives new input on scroll event from event listener

###

class root.TRACKER
  constructor: ( options ) ->

    @index = []

#    If options are given, attach them
    { @autostart } = options if options

    @autostart = true if @autostart is undefined

    @window = $( window )

    @active = false

    #    Count the amount of times broadcast has been called
    @counter = 0


    #    Store the registered scroll callbacks, labeled by name
    @subscribers =
      'tracker' : []


#   Set active to true (autostart), if not explicitly turned on
    if @autostart
      @start()




  ###

    Add subscribers callback function to call on broadcast

  ###
  subscribe: ( name, callback ) =>
    @subscribers[ name ].push( callback )




  ###

    Broadcast scroll event_id to subscribers

  ###
  broadcast: ( name, event_id ) =>
    @counter++
    for callback in @subscribers[ name ]
      callback( event_id )




  ###

    Pull needed data from event OBJECT and return new OBJECT

  ###
  disassemble: ( event ) ->

    if ( event.currentTarget isnt undefined )
      newEvent =
        'x': event.currentTarget.pageXOffset
        'y': event.currentTarget.pageYOffset
        'timeStamp': event.timeStamp
    else
      newEvent =
        'x': event.target.pageXOffset
        'y': event.target.pageYOffset
        'timeStamp': event.timeStamp

    newEvent




  ###

    Store the event in the @index[]
    return the event_id

  ###
  storeEvent: ( event ) ->

    @index.push( event ) - 1




  ###

    Start listening for scroll events

  ###
  start: ->

#    Prevent start from binding multiple scroll event listeners to the window
    if( @active )
      return false

    #    Bind scroll event listener to the window object
    @window.scroll ( rawEvent ) =>

      event = @disassemble rawEvent

      event_id = @storeEvent event

      @broadcast 'tracker', event_id

    @active = true




  ###

    Stop listening for scroll events

  ###
  stop: ->
    @window.off( 'scroll' )

    @active = false




  ###

    Trigger a scroll event manually

  ###
  trigger: ->
    @window.trigger( 'scroll' )

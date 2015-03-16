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
  constructor: ( options ) ->

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

    Broadcast scroll event to subscribers

  ###
  broadcast: ( name, event ) ->
    @counter++
    for callback in @subscribers[ name ]
      callback( event )




  ###

    Pull needed data from event object and return new object

  ###
  disassemble: ( event ) ->
    'offset':
      'x': event.target.pageXOffset
      'y': event.target.pageYOffset
    'timeStamp': event.timeStamp




  ###

    Start listening for scroll events

  ###
  start: () ->

#    Prevent start from binding multiple scroll event listeners to the window
    if( @active )
      return false

    #    Bind scroll event listener to the window object
    @window.scroll ( event ) =>

#      Broadcast the undressed event to all 'tracker' subscribers on event trigger
      @broadcast( 'tracker', @disassemble( event ) )

    @active = true




  ###

    Stop listening for scroll events

  ###
  stop: () ->
    @window.off( 'scroll' )

    @active = false




  ###

    Trigger a scroll event manually

  ###
  trigger: () ->
    @window.trigger( 'scroll' )

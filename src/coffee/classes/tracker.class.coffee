root = exports ? this

###

  TRACKER Class
  extends INIT class

  Receives new input on scroll event from event listener,

###

class root.TRACKER extends root.INIT
  constructor: () ->
    super

    #    Store all the events
    @index = []

    #    Is the tracker registering scroll events
    @active = false

#    Add a new channel to broadcast to
    @addChannel 'tracker'

#    Start registering scroll events
    if @autostart
      @start()




  ###

    Pull needed data from event OBJECT and return new OBJECT

  ###
  disassemble: ( event ) ->
    'y': if event.currentTarget then event.currentTarget.pageYOffset else event.target.pageYOffset
    'x': if event.currentTarget then event.currentTarget.pageXOffset else event.target.pageXOffset
    'timeStamp': event.timeStamp




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

#      Clean event and store it in @index[]
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

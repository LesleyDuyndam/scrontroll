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




  ###

    Pull needed data from event OBJECT and return new OBJECT

  ###
  extractCore: ( event ) ->
    'y': if event.currentTarget then event.currentTarget.pageYOffset else event.target.pageYOffset
    'x': if event.currentTarget then event.currentTarget.pageXOffset else event.target.pageXOffset
    'timeStamp': event.timeStamp



  ###

    Start listening for scroll events

    Return false if tracker is already running

  ###
  start: ->

    if( @active ) then return false

    @window.scroll ( event ) =>

      event_id = @index.push( @extractCore event ) - 1

      @broadcast 'tracker', event_id

    @active = true




  ###

    Stop listening for scroll events

  ###
  stop: ->
    if @active
      @window.off( 'scroll' )
      @active = false

    true




  ###

    Trigger a scroll event manually

  ###
  trigger: ->
    @window.trigger( 'scroll' )

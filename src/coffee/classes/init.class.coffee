root = exports ? this

###

  INIT Class

  1. TRACKER | receives new input on scroll event from event listener

###

class root.INIT
  constructor: ( options ) ->

    @window = $( window )

#    Store the registered scroll callbacks, labeled by name
    @channel = {}

#    If options are given, attach them
    { @autostart } = options if options

    @autostart = true if @autostart is undefined

#    Count the amount of times broadcast has been called
    @counter = 0





  ###

    Create a new channel where functions can subscribe callbacks to

  ###
  addChannel: ( name ) ->

#    Check if channel already exist
    if !@channel[ name ]

#     If not, create the channel
      @channel[ name ] = []

#
    else
#     If it does already exist, return false
      return false




  ###

    Add subscribers callback function to call on broadcast

  ###
  subscribe: ( name, callback ) =>
    @channel[ name ].push( callback )




  ###

    Broadcast scroll event_id to subscribers

  ###
  broadcast: ( name, event_id ) =>
    @counter++
    for callback in @channel[ name ]
      callback( event_id )
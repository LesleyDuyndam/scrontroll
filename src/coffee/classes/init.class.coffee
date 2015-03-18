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

    Add subscribers callback function to call on broadcast

  ###
  subscribe: ( name, callback ) ->

    if !@channel[ name ]
      @channel[ name ] = []

    @channel[ name ].push( callback )




  ###

    Broadcast scroll event_id to subscribers

  ###
  broadcast: ( name, data ) =>

    if( @channel[ name ] isnt undefined )

      @counter++
      for callback in @channel[ name ]
        callback( data )

      return data

    return false
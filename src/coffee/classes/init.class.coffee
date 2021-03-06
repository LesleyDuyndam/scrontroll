root = exports ? this

###

  INIT Class

  1. TRACKER | receives new input on scroll event from event listener

###

class root.INIT
  constructor: ( options ) ->

    @window = $( window )

#    Store the registered callbacks, where 'name' is the key
    @channel = {}

    #    If options are given, attach them
    { @autostart } = options if options

    @autostart = true if @autostart is undefined




  ###

    Check if a channel has been created

  ###
  channelExist: ( name ) ->
    Array.isArray( @channel[ name ] )




  ###

    Push subscribers callback to the channel[ name ]

  ###
  subscribe: ( name, callback ) ->
    if !@channelExist( name )
      @channel[ name ] = []

    @channel[ name ].push( callback ) - 1


  unsubscribe: ( name, subscription_id ) ->
    if @channelExist( name )
      return @channel[ name ][ subscription_id ] = null

    false




  ###

    Broadcast scroll data to subscribers

  ###
  broadcast: ( name, data ) =>

    if @channelExist( name )
      for callback in @channel[ name ]
        callback( data )

      return data

    return false

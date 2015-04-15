root = exports ? this

###

  INIT Class

  1. TRACKER | receives new input on scroll event from event listener

###

class root.INIT
  constructor: ( options ) ->

    @window = $( window )

#    Store the registered callbacks, where 'name' is the key
    @broadcasters = []
    @channel = {}

    @composers_name_register = []
    @composers_callback_register = []


    #    If options are given, attach them
    { @autostart } = options if options

    @autostart = true if @autostart is undefined



  ###

    Check if a composer has been created

  ###
  composerExist: ( name ) ->
    if @composers_name_register.indexOf( name ) is -1 then false else true





  ###

    Add composer to the
  ###
  addComposer: ( name, callback ) =>

    new_composer_name_array = []

    if typeof name is 'string'
      new_composer_name_array.push name

    if Array.isArray name
      new_composer_name_array = name

    if new_composer_name_array.length is 0
      return "Typeof #{ name } should be a string or array. Currently it is a #{ typeof name } type object"

    for composer in new_composer_name_array
      if !@composerExist name
        @composers_name_register.push name
        @composers_callback_register.push callback

      else
        return 'Composer already registered!'

    true






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

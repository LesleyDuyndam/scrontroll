describe 'jQuery', ->
  it 'should be defined', ->
    expect( jQuery ).toBeDefined()



describe 'Class root.INIT', ->

  Init = undefined
  callback = undefined

  beforeEach ->
    Init = new root.INIT()

    callback = ( data ) ->
      return true


  it 'should be defined', ->
    expect( Init ).toBeDefined()


  describe 'composerExist()',  ->
    it 'should be defined', ->
      expect( Init.composerExist ).toBeDefined()


    it 'should return FALSE if the composer does not exists', ->
      expect( Init.composerExist( 'testComposer' ) ).toBeFalsy()


    it 'should return TRUE if the channel exists', ->
      Init.composers_name_register.push( 'testComposer' )

      expect( Init.composerExist( 'testComposer' ) ).toBeTruthy()



  describe 'addComposer()', ->
    it 'should be defined', ->
      expect( Init.addComposer ).toBeDefined()


    it 'should return error message if first argument is not a string', ->
      expect( Init.addComposer( 0, callback ) ).toEqual( 'Name needs to be string, callback a function!' )


    it 'should return error message if second argument is not a object', ->
      expect( Init.addComposer( 'testComposer', 0 ) ).toEqual( 'Name needs to be string, callback a function!' )


    it 'should return true on success', ->
      expect( Init.addComposer( 'testComposer', callback ) ).toBeTruthy()



  describe 'channelExist()',  ->
    it 'should be defined', ->
      expect( Init.channelExist ).toBeDefined()


    it 'should return FALSE if the channel does not exists', ->
      expect( Init.channelExist( 'testChannel' ) ).toBeFalsy()


    it 'should return TRUE if the channel exists', ->
      Init.channel.testChannel = []

      expect( Init.channelExist( 'testChannel' ) ).toBeTruthy()



  describe 'subscribe()', ->
    it 'should be defined', ->
      expect( Init.subscribe ).toBeDefined()


    it 'should make a channel if not jet created', ->
      Init.subscribe( 'testChannel', callback )

      expect( Init.channelExist( 'testChannel' ) ).toBeTruthy()


    it 'should RETURN the subscription_id', ->
      expect( Init.subscribe( 'testChannel', callback ) ).toEqual( 0 )



  describe 'unsubscribe()', ->

    subscription_id = undefined

    beforeEach ->
      subscription_id = Init.subscribe( 'testChannel', callback )


    it 'should be defined', ->
      expect( Init.unsubscribe ).toBeDefined()


    it 'should return NULL on SUCCESS', ->
      expect( Init.unsubscribe 'testChannel', 0 ).toEqual( null )


    it 'should return FALSE on ERROR (channel does not exist)', ->
      expect( Init.unsubscribe 'testChannel', 1 ).toBeFalsy()



  describe 'broadcast()', ->

    subscription_id = undefined
    touched_data = undefined

    beforeEach ->
      subscription_id = Init.subscribe 'testChannel', ( data ) =>
        touched_data = "#{ data }-touched"


    it 'should be defined', ->
      expect( Init.broadcast ).toBeDefined()


    it 'should return DATA on success', ->
      expect( Init.broadcast( 'testChannel', 'dummyData' ) ).toEqual( 'dummyData' )


    it 'should return FALSE on error', ->
      expect( Init.broadcast( 'nonExistingChannel', 'dummyData' ) ).toBeFalsy()


    it 'should return run callbacks', ->
      Init.broadcast( 'testChannel', 'dummyData' )

      expect( touched_data ).toEqual( 'dummyData-touched' )
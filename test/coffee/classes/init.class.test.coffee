describe 'jQuery', ->
  it 'should be defined', ->
    expect( jQuery ).toBeDefined()




describe 'Class Init  ========================================', ->

  Init = null
  callback = null

  beforeEach ->
    Init = new TRACKER
      autostart : false


    callback = ( event_key ) ->
      return true

      Init.subscribe 'tracker', callback

      
  describe '@autostart', ->
    it 'should be defined', ->
      expect( Init.autostart ).toBeDefined()
  
    it 'should be false', ->
      expect( Init.autostart ).toBeFalsy()
  
  
  
  describe '@window', ->
    it 'should be defined.', ->
      expect( Init.window ).toBeDefined()
  
  
  
  
  describe '@active', ->
    it 'should be defined.', ->
      expect( Init.active ).toBeDefined()
  
    it 'should be false', ->
      expect( Init.active ).toBeFalsy()
  
  
  
  
  describe '@channel', ->
    it 'should be defined.', ->
      expect( Init.channel ).toBeTruthy()
  
  
  
  
  describe '@counter', ->
    it 'should be defined', ->
      expect( Init.counter ).toBeDefined()
  
    it 'should be 0.', ->
      expect( Init.counter ).toBe( 0 )



  describe '@subscribe().', ->
    it 'should be a defined method.', ->
      expect( Init.subscribe ).toBeDefined()

    it 'should return TRUE.', ->
      expect( Init.subscribe( 'tracker', callback ) ).toBeTruthy()

    it 'should update the @subscribers property, so its length is > 0.', ->
      Init.subscribe( 'tracker', callback )
      expect( Init.channel.tracker.length ).not.toBe( 0 )

    it 'should have pushed a ( testing ) callback function to the @subscribers array which returns TRUE.', ->
      Init.subscribe( 'tracker', callback )
      expect( Init.channel.tracker[0]() ).toBe( true )




  describe '@subscribers.tracker', ->
    it 'should be an ARRAY.', ->
      Init.subscribe( 'tracker', callback )

      expect( Array.isArray( Init.channel.tracker ) ).toBeTruthy()


  describe '@broadcast()', ->
    it 'should be a defined method.', ->
      expect( Init.broadcast ).toBeDefined()


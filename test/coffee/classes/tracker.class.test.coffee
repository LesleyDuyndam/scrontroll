###
  TRACKER Class test
###

describe 'jQuery', ->
  it 'should be defined', ->
    expect( jQuery ).toBeDefined()




describe 'Class Tracker', ->

  Tracker = null
  callback = null

  beforeEach ->
    Tracker = new TRACKER
      autostart : false


    callback = ( event_key ) ->
      return true

      Tracker.subscribe 'tracker', callback





  it 'should be defined', ->
    console.dir Tracker
    expect( Tracker ).toBeDefined()




  describe '@autostart', ->
    it 'should be defined', ->
      expect( Tracker.autostart ).toBeDefined()

    it 'should be false', ->
      expect( Tracker.autostart ).toBeFalsy()



  describe '@window', ->
    it 'should be defined.', ->
      expect( Tracker.window ).toBeDefined()




  describe '@active', ->
    it 'should be defined.', ->
      expect( Tracker.active ).toBeDefined()

    it 'should be false', ->
      expect( Tracker.active ).toBeFalsy()




  describe '@subscribers', ->
    it 'should be defined.', ->
      expect( Tracker.subscribers ).toBeTruthy()




  describe '@counter', ->
    it 'should be defined', ->
      expect( Tracker.counter ).toBeDefined()

    it 'should be 0.', ->
      expect( Tracker.counter ).toBe( 0 )




  describe '@subscribe().', ->
    it 'should be a defined method.', ->
      expect( Tracker.subscribe ).toBeDefined()

    it 'should return TRUE.', ->
      expect( Tracker.subscribe( 'tracker', callback ) ).toBeTruthy()

    it 'should update the @subscribers property, so its length is > 0.', ->
      Tracker.subscribe( 'tracker', callback )
      expect( Tracker.subscribers.tracker.length ).not.toBe( 0 )

    it 'should have pushed a ( testing ) callback function to the @subscribers array which returns TRUE.', ->
      Tracker.subscribe( 'tracker', callback )
      expect( Tracker.subscribers.tracker[0]() ).toBe( true )




  describe '@subscribers.tracker', ->
    it 'should be an ARRAY.', ->
      Tracker.subscribe( 'tracker', callback )

      expect( Array.isArray( Tracker.subscribers.tracker ) ).toBeTruthy()


  describe '@broadcast()', ->
    it 'should be a defined method.', ->
      expect( Tracker.broadcast ).toBeDefined()




  describe '@disassemble', ->
    it 'should be a defined method.', ->
      expect( Tracker.disassemble ).toBeDefined()

    event =
      'timeStamp' : 10
      'target' :
        'pageXOffset' : 0
        'pageYOffset' : 0

    it 'should return a disassembled object', ->
      expect( Tracker.disassemble( event ) ).toEqual(
        'x' : 0
        'y' : 0
        'timeStamp' : 10
      )


  describe '@storeEvent', ->
    it 'should push an event to the index', ->
      Tracker.storeEvent( 'Dummy filling' )

      expect( Tracker.storeEvent( 'someData' ) ).toEqual( 1 )






  describe '@start()', ->
    it 'should turn window scroll events on', ->
      expect( Tracker.start() ).toBeTruthy()

    it 'should NOT start, if already running', ->
      Tracker.start()
      expect( Tracker.start() ).toBeFalsy()

    it 'should update the counter after a event trigger', ->

      Tracker.start()
      Tracker.trigger()

      expect( Tracker.counter ).toBe( 1 )




  describe '@stop()', ->
    it 'should be a defined method.', ->
      expect( Tracker.stop ).toBeDefined()

    it 'should turn window scroll events off', ->
      expect( Tracker.stop() ).toBeFalsy()

    it 'should NOT update the counter after a event trigger', ->

      Tracker.trigger()

      expect( Tracker.counter ).toBe( 0 )

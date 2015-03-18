###
  TRACKER Class test
###

###
  Setup the tests
###

describe 'Class Tracker  ========================================', ->

  Tracker = null
  callback = null

  event =
    'timeStamp' : 10
    'target' :
      'pageXOffset' : 0
      'pageYOffset' : 0

  beforeEach ->
    Tracker = new TRACKER
      autostart : false


    callback = ( event_key ) ->
      return true

    Tracker.subscribe 'tracker', callback









  ###
    Run METHOD tests
  ###

  it 'should be defined', ->
    console.dir Tracker
    expect( Tracker ).toBeDefined()




  describe '@disassemble()', ->
    it 'should be a defined method.', ->
      expect( Tracker.disassemble ).toBeDefined()

    it 'should return a disassembled object', ->
      expect( Tracker.disassemble( event ) ).toEqual(
        'x' : 0
        'y' : 0
        'timeStamp' : 10
      )



#
#  describe '@storeEvent()', ->
#    it 'should push an event to the index', ->
#      Tracker.storeEvent( 'Dummy filling' )
#
#      expect( Tracker.storeEvent( 'someData' ) ).toEqual( 1 )




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

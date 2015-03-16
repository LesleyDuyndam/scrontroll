###
  TRACKER Class test
###

describe 'jQuery', ->
  it 'should be defined', ->
    expect( jQuery ).toBeDefined()




describe 'Class Tracker', ->
  Tracker = new TRACKER(
    autostart : false
  )
  it 'should be defined', ->
    expect( Tracker ).toBeDefined()




  describe 'PROPERTY: @autostart', ->
    it 'should be defined', ->
      expect( Tracker.autostart ).toBeDefined()

    it 'should be false', ->
      expect( Tracker.autostart ).toBeFalsy()



  describe 'PROPERTY: @window', ->
    it 'should be defined.', ->
      expect( Tracker.window ).toBeDefined()




  describe 'PROPERTY: @active', ->
    it 'should be defined.', ->
      expect( Tracker.active ).toBeDefined()

    it 'should be false', ->
      expect( Tracker.active ).toBeFalsy()




  describe 'PROPERTY: @subscribers', ->
    it 'should be defined.', ->
      expect( Tracker.subscribers ).toBeTruthy()



  describe 'PROPERTY: @subscribers.tracker', ->
    it 'should be an ARRAY.', ->
      expect( Array.isArray( Tracker.subscribers.tracker ) ).toBeTruthy()




  describe 'PROPERTY: @counter', ->
    it 'should be defined', ->
      expect( Tracker.counter ).toBeDefined()

    it 'should be 0.', ->
      expect( Tracker.counter ).toBe( 0 )




  describe 'METHOD  : @subscribe().', ->
    callback = () ->
      return true

    it 'should be a defined method.', ->
      expect( Tracker.subscribe ).toBeDefined()

    it 'should be a an array.', ->
      expect( Tracker.subscribe ).toBeDefined()

    it 'should return TRUE.', ->
      expect( Tracker.subscribe( 'tracker', callback ) ).toBeTruthy()

    it 'should update the @subscribers property, so its length is > 0.', ->
      expect( Tracker.subscribers.tracker.length ).not.toBe( 0 )

    it 'should have pushed a ( testing ) callback function to the @subscribers array which returns TRUE.', ->
      expect( Tracker.subscribers.tracker[0]() ).toBe( true )




  describe 'METHOD  : @broadcast()', ->
    it 'should be a defined method.', ->
      expect( Tracker.broadcast ).toBeDefined()




  describe 'METHOD  : @disassemble', ->
    it 'should be a defined method.', ->
      expect( Tracker.disassemble ).toBeDefined()

    event =
      'timeStamp' : 10
      'target' :
        'pageXOffset' : 0
        'pageYOffset' : 0

    it 'should return a disassembled object', ->
      expect( Tracker.disassemble( event ) ).toEqual(
        'offset' :
          'x' : 0
          'y' : 0
        'timeStamp' : 10
      )




  describe 'METHOD  : @start()', ->
    it 'should turn window scroll events on', ->
      expect( Tracker.start() ).toBeTruthy()

    it 'should NOT start, if already running', ->
      Tracker.start()
      expect( Tracker.start() ).toBeFalsy()

    it 'should update the counter after a event trigger', ->

      Tracker.start()

      counterBeforeTrigger = Tracker.counter
      Tracker.trigger()

      expect( Tracker.counter ).toBe( counterBeforeTrigger + 1 )




  describe 'METHOD  : @stop()', ->
    it 'should be a defined method.', ->
      expect( Tracker.stop ).toBeDefined()

    it 'should turn window scroll events off', ->
      expect( Tracker.stop() ).toBeFalsy()

    it 'should NOT update the counter after a event trigger', ->

      counterBeforeTrigger = Tracker.counter
      Tracker.trigger()

      expect( Tracker.counter ).toBe( counterBeforeTrigger )

###
  EXAMPLE Class test
###

describe 'jQuery', ->

  it 'should be defined', ->
    expect( jQuery ).toBeDefined()

Tracker = new TRACKER(
  autostart : false
)

describe 'Class Tracker', ->

  Tracker = new TRACKER(
    autostart : false
  )


  it 'should be defined', ->
    expect( Tracker ).toBeDefined()

  it 'should have an options property to be defined', ->
    expect( Tracker.options ).toBeDefined()

  it 'should have an option "autostart", set to false', ->
    expect( Tracker.options.autostart ).toBeFalsy()



  # Properties tests
  describe 'PROPERTY: @window', ->
    it 'should be defined.', ->
      expect( Tracker.window ).toBeDefined()



  describe 'PROPERTY: @active', ->
    it 'should be defined.', ->
      expect( Tracker.active ).toBeDefined()

    it 'should be false', ->
      expect( Tracker.active ).toBeFalsy()



  describe 'PROPERTY: @subscribers', ->
    it 'should be an ARRAY.', ->
      expect( Array.isArray( Tracker.subscribers ) ).toBeTruthy()

    it 'should have a length of 0.', ->
      expect( Tracker.subscribers.length ).toBe( 0 )



  describe 'PROPERTY: @counter', ->
    it 'should be defined', ->
      expect( Tracker.counter ).toBeDefined()

    it 'should be 0.', ->
      expect( Tracker.counter ).toBe( 0 )






  # Methods tests more test
  describe 'METHOD  : @subscribe().', ->
    callback = () ->
      return true

    it 'should be a defined method.', ->
      expect( Tracker.subscribe ).toBeDefined()

    it 'should return TRUE.', ->
      expect( Tracker.subscribe( callback ) ).toBeTruthy()

    it 'should update the @subscribers property, so its length is > 0.', ->
      expect( Tracker.subscribers.length ).not.toBe( 0 )

    it 'should have pushed a ( testing ) callback function to the @subscribers array which returns TRUE.', ->
      expect( Tracker.subscribers[0]() ).toBe( true )




  describe 'METHOD  : @broadcast()', ->
    it 'should be a defined method.', ->
      expect( Tracker.broadcast ).toBeDefined()


  describe 'METHOD  : @start()', ->
    it 'should turn window scroll events on', ->
      expect( Tracker.start() ).toBeTruthy()

    it 'should update the counter after a event trigger', ->

      counterBeforeTrigger = Tracker.counter
      Tracker.trigger()

      expect( Tracker.counter ).toBe( counterBeforeTrigger + 1 )




  describe 'METHOD  : @stop()', ->
    it 'should turn window scroll events off', ->
      expect( Tracker.stop() ).toBeFalsy()

    it 'should NOT update the counter after a event trigger', ->

      counterBeforeTrigger = Tracker.counter
      Tracker.trigger()

      expect( Tracker.counter ).toBe( counterBeforeTrigger )


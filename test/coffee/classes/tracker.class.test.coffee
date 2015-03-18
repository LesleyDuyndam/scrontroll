describe 'Class root.TRACKER', ->

  Tracker = undefined
  callback = undefined
  event = undefined
  control_event = undefined

  beforeEach ->
    Tracker = new root.TRACKER

    callback = ( data ) ->
      return true

    event =
      'target' :
        'pageYOffset' : 10
        'pageXOffset' : 15
      'timeStamp' : 1234567891000

    control_event =
      'y' : 10
      'x' : 15
      'timeStamp' : 1234567891000


  it 'should be defined', ->
    expect( Tracker ).toBeDefined()


  describe 'extractCore', ->
    it 'should be defined', ->
      expect( Tracker.extractCore ).toBeDefined()

    it 'should return an EVENT object', ->
      expect( Tracker.extractCore event ).toEqual( control_event )


  describe 'start()', ->
    it 'should be defined', ->
      expect( Tracker.start ).toBeDefined()

    it 'should return true on success', ->
      expect( Tracker.start() ).toBeTruthy()

    it 'should return false if already running', ->
      Tracker.start()

      expect( Tracker.start() ).toBeFalsy()


  describe 'stop()', ->
    it 'should be defined', ->
      expect( Tracker.stop ).toBeDefined()

    it 'should return true on success', ->
      expect( Tracker.stop() ).toBeTruthy()


  describe 'trigger()', ->
    it 'should be defined', ->
      expect( Tracker.trigger ).toBeDefined()

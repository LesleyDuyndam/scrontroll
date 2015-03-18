###
  Scrontroll Class test
###

events = [{
  'x': 0
  'y': 0
  'timeStamp': 1426546660427
},{
  'x': 10
  'y': 10
  'timeStamp': 1426546661427
},{
  'x': 20
  'y': 20
  'timeStamp': 1426546662427
},
]

singleEvent =
  'x': 15
  'y': 15
  'timeStamp': 1426546663427


describe 'Class Scrontroll  ========================================', ->

  Scrontroll = null

  beforeEach ->
    Scrontroll = new SCRONTROLL
      'autostart' : false


    #    Simulate scroll events and inject them in the tracker core
    for event in events
      Scrontroll.broadcast 'tracker', Scrontroll.index.push( event )


  it 'should be defined', ->
    console.dir Scrontroll
    expect( Scrontroll ).toBeDefined()




  describe '@watch()', ->
    it 'should be defined', ->
      expect( Scrontroll.watch ).toBeDefined()

    it 'should be called on a broadcast from the engine', ->

      # Set up the watcher, so it functionality can be tested
      Scrontroll.watch 'direction', ( direction ) =>
        @direction = direction

      # broadcast to tracker, let it bubble up to watch so @direction will get data
      Scrontroll.broadcast 'tracker', Scrontroll.index.push( singleEvent ) - 1

      expect( @direction ).toBe( 'up' )




  describe '@controller()', ->
    it 'should be defined', ->
      expect( Scrontroll.controller ).toBeDefined()

    it 'should return FALSE (value did not change, do nothing)', ->
      expect( Scrontroll.controller( 2 ) ).toEqual( false )

    it 'should return "down"', ->

      # Set up the watcher, so it functionality can be tested
      Scrontroll.watch 'direction', ( direction ) =>
        @direction = direction

      expect( Scrontroll.controller( 1 ) ).toEqual( 'down' )


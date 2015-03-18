###
  ENGINE Class test
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
  'x': 30
  'y': 30
  'timeStamp': 1426546663427


describe 'Class Engine  ========================================', ->

  Engine = null

  beforeEach ->
    Engine = new ENGINE
      'autostart' : false


#    Simulate scroll events and inject them in the tracker core
    for event in events
      Engine.broadcast 'tracker', Engine.storeEvent event


  it 'should be defined', ->
    console.dir Engine
    expect( Engine ).toBeDefined()


  describe '@supervisor', ->
    it 'should be defined', ->
      expect( Engine.supervisor ).toBeDefined()

    it 'should update the event objects in @index', ->
      expect( Engine.index[ Engine.supervisor( 2 ) ] ).toEqual({
        'x': 20
        'y': 20
        'timeStamp': 1426546662427
        'direction' :
          'x' : 'right'
          'y' : 'down'
        'speed' :
          'x' : 10
          'y' : 10
      })
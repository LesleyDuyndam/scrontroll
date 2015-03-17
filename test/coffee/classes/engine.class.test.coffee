###
  PROCESSOR Class test
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


describe 'Class Engine', ->

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


  describe '@calc_direction', ->
    it 'should return false if first event', ->
      expect( Engine.calc_direction( 0 ) ).toBeFalsy()

    it 'should return an object with 2 keys', ->

      directions = Engine.calc_direction( 2 )

      expect( directions ).toEqual({
        x : 'down'
        y : 'right'
      })


  describe '@calc_speed', ->
    it 'should return an integer', ->

      speed = Engine.calc_speed( 2 )

      console.dir speed

      expect( speed ).toEqual({
        x : 10
        y : 10
      })




  describe '@supervisor', ->
    it 'should be defined', ->
      expect( Engine.supervisor ).toBeDefined()
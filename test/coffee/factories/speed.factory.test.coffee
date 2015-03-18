describe 'root.speed', ->

  this_event = undefined
  prev_event = undefined
  default_return = undefined
  speed_return = undefined

  beforeEach ->
    prev_event =
      'y' : 15
      'x' : 15
      'timeStamp' : 1234567892000

    this_event =
      'y' : 25
      'x' : 25
      'timeStamp' : 1234567893000


    default_return =
      'y'         : 0
      'x'         : 0

    speed_return =
      'y'         : 10
      'x'         : 10





  it 'should be defined', ->
    expect( root.speed ).toBeDefined()

  it 'should return defaults if prev_event is undefined', ->
    expect( root.speed this_event, undefined ).toEqual( default_return )

  it 'should return speed_return', ->
    expect( root.speed this_event, prev_event ).toEqual( speed_return )
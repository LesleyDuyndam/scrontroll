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



describe 'root.average_speed()', ->

  @event_list = []
  @expextation = {}

  beforeEach ->
    @event_list = [
      { speed: { x: 12, y: 12 } },
      { speed: { x: 9, y: 10 } },
      { speed: { x: 28, y: 12 } },
      { speed: { x: 1, y: 10 } },
      { speed: { x: 3093, y: 12 } },
      { speed: { x: 1200, y: 10 } },
      { speed: { x: 1, y: 12 } },
      { speed: { x: 1, y: 10 } },
    ]

    @expectation_float_3 =
      y : 11
      x : 543.125


    @expectation_float_2 =
      y : 11
      x : 543.13

    @expectation_int =
      y : 11
      x : 543

  it 'should be defined', ->
    expect( root.average_speed ).toBeDefined()

  it 'should return an average speed object with values a maximal decimal of 3 (auto)', ->
    expect( root.average_speed( @event_list ) ).toEqual( @expectation_float_3 )

  it 'should return an average speed object with values of a integer', ->
    expect( root.average_speed( @event_list, 2 ) ).toEqual( @expectation_float_2 )

  it 'should return an average speed object with values of a integer', ->
    expect( root.average_speed( @event_list, false ) ).toEqual( @expectation_int )
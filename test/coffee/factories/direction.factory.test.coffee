describe 'root.direction', ->

  this_event_down = undefined
  prev_event_down = undefined
  this_event_up = undefined
  prev_event_up = undefined
  default_return = undefined
  down_return = undefined
  up_return = undefined

  beforeEach ->
    prev_event_down =
      'y' : 15
      'x' : 15
      'timeStamp' : 1234567892000
      'direction' :
        'y' : 'down'
        'x' : 'right'
        'yChanged' : false,
        'xChanged' : false

    this_event_down =
      'y' : 25
      'x' : 25
      'timeStamp' : 1234567893000

    prev_event_up =
      'y' : 35
      'x' : 35
      'timeStamp' : 1234567894000
      'direction' :
        'y' : 'down'
        'x' : 'right'
        'yChanged' : false,
        'xChanged' : false

    this_event_up =
      'y' : 20
      'x' : 20
      'timeStamp' : 1234567895000

    default_return =
      'y'         : 'atTop'
      'x'         : 'atLeft'
      'yChanged'  : true
      'xChanged'  : true

    down_return =
      'y'         : 'down'
      'x'         : 'right'
      'yChanged'  : false
      'xChanged'  : false

    up_return =
      'y'         : 'up'
      'x'         : 'left'
      'yChanged'  : true
      'xChanged'  : true




  it 'should be defined', ->
    expect( root.direction ).toBeDefined()

  it 'should return defaulst if prev_event is undefined', ->
    expect( root.direction this_event_down, undefined ).toEqual( default_return )

  it 'should return down_return (directions did not change)', ->
    expect( root.direction this_event_down, prev_event_down ).toEqual( down_return )

  it 'should return up_return (directions did change)', ->
    expect( root.direction this_event_up, prev_event_up ).toEqual( up_return )
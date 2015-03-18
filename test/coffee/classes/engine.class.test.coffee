describe 'Class root.ENGINE', ->

  Engine = undefined
  callback = undefined

  control_return = undefined

  beforeEach ->
    Engine = new root.ENGINE

    callback = ( data ) ->
      return "#{ data }-touched"


    Engine.index.push(
      'x': 10
      'y': 15
      'timeStamp': 1234567891000
      'direction':
        'y'         : 'down'
        'x'         : 'right'
        'yChanged'  : false
        'xChanged'  : false
    )

    Engine.index.push(
      'x': 5
      'y': 5
      'timeStamp': 1234567892000
      'direction':
        'y'         : 'up'
        'x'         : 'left'
        'yChanged'  : true
        'xChanged'  : true
    )

    Engine.index.push(
      'x': 15
      'y': 25
      'timeStamp': 1234567893000
    )

    control_return =
      'x': 15
      'y': 25
      'timeStamp': 1234567893000
      'direction':
        'y'         : 'down'
        'x'         : 'right'
        'yChanged'  : true
        'xChanged'  : true

  it 'should be defined', ->
    expect( Engine ).toBeDefined()


  describe 'router()', ->
    it 'should be defined', ->
      expect( Engine.router ).toBeDefined()

    it 'should return the event_id if NO channels exist', ->
      expect( Engine.router 1 ).toBe( 1 )

    it 'should return the DIRECTION Object if DIRECTION has subscribers', ->

      direction_return = undefined
      Engine.subscribe 'direction', ( object ) ->
        console.log( "direction returns #{ object }" )
        direction_return = object

      Engine.router 2

      expect( direction_return ).toEqual( control_return )

    it 'should return the VERTICAL-DIRECTION if channel HORIZONTAL-DIRECTIONS has subscribers', ->

      vertical_return = undefined
      Engine.subscribe 'vertical-direction', ( string ) ->
        vertical_return = string

      Engine.router 2

      expect( vertical_return ).toEqual( control_return.direction.y )
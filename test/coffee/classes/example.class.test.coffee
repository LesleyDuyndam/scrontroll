###
  EXAMPLE Class test
###
Tracker = new TRACKER()





describe 'Class Tracker', ->

  it 'should be defined', ->
    expect( Tracker ).toBeDefined()





describe 'Class Tracker @subscribers property', ->

  it 'should be an array', ->
    expect( Array.isArray( Tracker.subscribers ) ).toBeTruthy()

  it 'should have a length of 0', ->
    expect( Tracker.subscribers.length ).toBe( 0 )




describe 'Class Tracker @subscribe() method', ->

  it 'should return true', ->

    callback = () ->
      return true

    expect( Tracker.subscribe( callback ) ).toBeTruthy()

  it 'should update the @subscribers property length to 1', ->
    expect( Tracker.subscribers.length ).toBe( 1 )

  it 'should have pushed a function to the @subscribers array', ->
    Expect( Tracker.subscribers[0] ).toBe()
# @todo finish test



describe 'Class Tracker @broadcast() method', ->

  it 'should be a defined method', ->
    expect( Tracker.broadcast ).toBeDefined()

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





describe 'Class Tracker @subscribe() method', ->

  it 'should return true', ->
    expect( Tracker.subscribe( 'subscribers callback' ) ).toBeTruthy()

  it 'should update the @subscribers property', ->
    expect( Tracker.subscribers.length ).toBe( 1 )





describe 'Class Tracker @broadcast() method', ->

  it 'should be a defined method', ->
    expect( Tracker.broadcast ).toBeDefined()

root = exports ? this

prev_event =
  'x': 10
  'y': 10
  'timeStamp': 1426546661427

this_event =
  'x': 20
  'y': 20
  'timeStamp': 1426546662427

no_event = undefined

describe 'root.direction()', ->
  it 'should return defaults if prev_event is undefined', ->
    expect( root.direction( this_event, no_event ) ).toEqual({ 'x' : 'atLeft', 'y' : 'atTop' })

  it 'should return a direction OBJECT', ->
    expect( root.direction( this_event, prev_event ) ).toEqual({ 'x' : 'right', 'y' : 'down' })
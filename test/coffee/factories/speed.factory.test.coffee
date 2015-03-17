
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

describe 'root.speed()', ->
  it 'should return a speed OBJECT', ->
    expect( root.speed( this_event, prev_event ) ).toEqual({ 'x' : 10, 'y' : 10 })
###
  PROCESSOR Class test
###

describe 'Class Processor', ->

  Processor = null
  event = null

  beforeEach ->
    Processor = new PROCESSOR()

    event =
      'offset' :
        'x' : 0
        'y' : 0
      'timeStamp' : 10

  it 'should be defined', ->
    expect( Processor ).toBeDefined()



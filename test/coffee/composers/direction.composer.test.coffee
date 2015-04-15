describe 'root.direction_composer()', ->

  name_single = new Array()
  name_array = new Array()
  event_id = 0
  callback = new Object()

  beforeEach ->

    @index = []

    name_single = [
      'testName'
    ]

    name_array = [
      'testName',
      'secondTestName'
    ]

    event_id = 1

    callback = () ->
      return true


  it 'should be defined', ->
    expect( root.direction_composer ).toBeDefined()

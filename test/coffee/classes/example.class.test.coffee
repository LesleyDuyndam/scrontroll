###
  EXAMPLE Class test
###

describe 'Class EXAMPLE', ->

# Assign an instance of the EXAMPLE class to a variable to make it testable
  example = new EXAMPLE()

  it 'should be defined.', ->
    expect( example ).toBeDefined()

  it 'should have a method who returns a property with the value true.', ->
    expect( example.method() ).toBeTruthy()

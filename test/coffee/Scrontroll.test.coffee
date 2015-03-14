###
  index test
###

describe 'index', ->

# Assign an instance of the EXAMPLE class to a variable to make it testable
  it 'should have a example object.', ->
    expect( indexExample ).toBeDefined()

  it 'should have a method who returns a property with the value true.', ->
    expect( indexExample.method() ).toBeTruthy()

describe "Split", ->

  beforeEach ->
    module = require('../../src/js/split.js')
    splitter = require('../../src/js/StringSplitter.js')
    StringSplitter = new splitter.StringSplitter()
    spyOn process.stdout, 'write'
    spyOn(StringSplitter, 'stringsOf').andCallFake (text)-> [ 'x','y' ]
    spyOn StringSplitter, 'nextPositionIn'
    @split = new module.Split(StringSplitter)

  it "should print the splitted strings", ->
    text = ' blah blah blah. '
    @split.run(text)
    expect(process.stdout.write).toHaveBeenCalledWith 'x\n'
    expect(process.stdout.write).toHaveBeenCalledWith 'y\n'

  it "should print the splitted strings with prefix ...- if french", ->
    text = '...-blah blah blah. '
    @split.run(text)
    expect(process.stdout.write).toHaveBeenCalledWith '...-x\n'
    expect(process.stdout.write).toHaveBeenCalledWith '...-y\n'
    


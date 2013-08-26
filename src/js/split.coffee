String.prototype.trim = -> @replace /^\s+|\s+$/g, ''
exports.Split = class Split
  FRMARK: '...'
  constructor:(StringSplitter) ->
    if not StringSplitter
      module = require("./StringSplitter.js").StringSplitter
      StringSplitter = new module()
    @splitter = StringSplitter

  run: (text)->
    isFr = no
# console.log will do the same as process.stdout.write
# ( making text being read twice or more)
    if text.indexOf(@FRMARK) == 0
      text = text.substring(@FRMARK.length)
      isFr = yes
    strings = @splitter.stringsOf(text)

    for string in strings
      if isFr
        string = "#{@FRMARK}-#{string}"
      process.stdout.write string + "\n"

process.argv.shift()
process.argv.shift()
text = process.argv.join(" ")
if text != 'test'
  split = new exports.Split()
  split.run(text)
  process.exit 0

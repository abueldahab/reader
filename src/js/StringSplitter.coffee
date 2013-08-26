exports.StringSplitter = class StringSplitter

  DEFAULT_SPLITTERS = [". ", ". ", ", ", ",", ";", ":", "|", " ", ".", ".", "،", "، "]
  DEFAULT_CHARACTERS_LIMIT = 100

  constructor: (@characterLimit=DEFAULT_CHARACTERS_LIMIT, @splitters=DEFAULT_SPLITTERS) ->

  nextPositionIn: (text) ->
    i = text.length
    iteration = 0
    if i > @characterLimit
      i = text.lastIndexOf(@splitters[iteration], @characterLimit)
      while i < 1 and iteration < @splitters.length
        iteration = iteration + 1
        i = text.lastIndexOf(@splitters[iteration], @characterLimit)
      if i < 1 then i = text.length else i
    else
      i

  stringsOf: (text) ->
    i = 0
    list = []
    while text.length > @characterLimit
      i = @nextPositionIn(text)
      list.push text.substring(0, i + 1)
      text = text.substring(i + 1)
    list.push text
    list

  setCharacterLimit: (limit)->
    @characterLimit = limit


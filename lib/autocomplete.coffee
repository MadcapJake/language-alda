p    = require 'path'
S    = require 'underscore.string'
CSON = require 'season'

module.exports =
  # This will work on Alda files but not on comments in Alda files
  selector: '.source.alda'
  disableForSelector: '.source.alda .comment'

  # This will take priority over the default provider, Alda is a very specific
  # language that doesn't require a lot of words, so there's no great need to
  # allow regular autocomplete to happen.
  inclusionPriority: 1
  excludeLowerPriority: true

  # Return an array of suggestions or null
  # `request` has the following properties:
  # * editor: The current TextEditor
  # * bufferPosition: The position of the cursor
  # * scopeDescriptor: The scope descriptor for the current cursor position
  # * prefix: The prefix for the word immediately preceding the current cursor
  #   position
  getSuggestions: (request) ->
    completions = null
    # scopes = request.scopeDescriptor.getScopesArray()
    # isAlda = hasScope(scopes, 'source.alda')

    if @isCompletingMarker(request)
      completions = @getMarkerComps(request)
    else if @isCompletingAttribute(request)
      completions = @getAttributeComps(request)
    else if @isCompletingInstrument(request)
      completions = @getInstrumentComps(request)

    completions

  loadCompletions: ->
    CSON.readFile p.resolve(__dirname, '..', 'completions.cson'), (err, src) =>
      {@attributes, @instruments} = src unless err?
      return

  isCompletingMarker: ({scopeDescriptor, bufferPosition, prefix, editor}) ->
    S.startsWith(prefix, '@')

  isCompletingAttribute: ({scopeDescriptor, bufferPosition, prefix, editor}) ->
    scopeDescriptor.getScopesArray().indexOf('meta.attribute.alda') isnt -1

  isCompletingInstrument: ({scopeDescriptor, bufferPosition, prefix, editor}) ->
    prefix.length > 2 and not S.include(prefix, ':') and
      bufferPosition.column - prefix.length is 0

  getMarkerComps: ({scopeDescriptor, bufferPosition, prefix, editor}) ->

  getAttributeComps: ({scopeDescriptor, bufferPosition, prefix, editor}) ->
    console.log prefix
    completions = []
    if prefix
      console.log @attributes
      for attr in @attributes when firstCharsEqual(attr, prefix)
        console.log "prefix: #{prefix}, attr: #{attr}"
        completions.push(@buildAttributeComp(attr))
      completions

  buildAttributeComp: (attr) ->
    type: 'attribute'
    snippet: "#{attr} ${1:99}$2"
    displayText: attr
    iconHTML: '<i class="icon-settings"></i>'
    rightLabel: 'Attribute'

  getInstrumentComps: ({scopeDescriptor, bufferPosition, prefix, editor}) ->

firstCharsEqual = (str1, str2) ->
  str1[0].toLowerCase() is str2[0].toLowerCase()

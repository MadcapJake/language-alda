autocompleteProvider = require './autocomplete'
atomBuildProvider    = require './atombuild'

module.exports =
  config:
    buildDebugMode:
      title: "Build - Debug Mode"
      description: "With atom-build, provides verbose logging"
      type: "boolean"
      default: false
      order: 1
    buildPreBuffer:
      title: "Build - Pre-Buffer"
      description: "With atom-build, adds pre-buffer (in ms) to args"
      type: "number"
      default: 0
      minimum: 0
      maximum: 6000

  activate: ->
    autocompleteProvider.loadCompletions()

  getAutocompleteProvider: -> autocompleteProvider

  getAtomBuildProvider: -> atomBuildProvider

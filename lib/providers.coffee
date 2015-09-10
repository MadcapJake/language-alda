autocompleteProvider = require './autocomplete'
atomBuildProvider    = require './atombuild'

module.exports =
  config:
    debugMode:
      title: "Build - Debug Mode"
      description: "When using `atom-build`, provides verbose logging"
      type: "boolean"
      default: false
      order: 1

  activate: ->
    autocompleteProvider.loadCompletions()

  getAutocompleteProvider: -> autocompleteProvider

  getAtomBuildProvider: -> atomBuildProvider

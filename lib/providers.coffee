autocompleteProvider = require './autocomplete'

module.exports =

  activate: ->
    autocompleteProvider.loadCompletions()

  getAutocompleteProvider: -> autocompleteProvider

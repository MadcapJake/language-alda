_ = require 'underscore'
P = require 'path'
F = require 'fs'

module.exports =

  niceName: 'Alda'

  isEligable: (path) ->
    _.any(F.readdirSync(path), (file) -> P.extname(file) is ".alda")

  settings: (path) ->
    new Promise (resolve, reject) ->
      config =
        exec: 'alda'
        name: 'Alda: play'
        args: ['play', '--file', '{FILE_ACTIVE}']
        cwd: '/home/jrusso/github/alda/'
        errorFile: '{FILE_ACTIVE}'
        errorMatch: 'Parse error at line (?<line>\\d+), column (?<col>\\d+):'
        keymap: 'ctrl-shift-space'

      if atom.config.get('language-alda.buildDebugMode')
        config['env'] = TIMBRE_LEVEL: 'debug'

      preBuffer = atom.config.get('language-alda.buildPreBuffer')
      if preBuffer isnt 0
        config.args.splice(1, 0, "--pre-buffer #{preBuffer}")
      resolve(config)

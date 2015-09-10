_ = require 'underscore'
p = require 'path'

module.exports =

  niceName: 'Alda'

  isEligable: (path) ->
    _.any(fs.readdirSync(path), (f) -> p.extname(f) is ".alda")

  settings: (path) ->
    new Promise (resolve, reject) ->
      config =
        cmd: 'alda'
        name: 'Alda: play'
        args: ['play', '--file', '{FILE_ACTIVE_NAME}']
        errorMatch: ''

      if atom.config.get('language-alda.debugMode')
        config['env'] = TIMBRE_LEVEL: 'debug'

      resolve(config)

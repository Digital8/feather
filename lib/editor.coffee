{EventEmitter} = require 'events'

module.exports = class Editor extends EventEmitter
  constructor: (args = {}) ->
    super
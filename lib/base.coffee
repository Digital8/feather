{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Base extends EventEmitter
  
  constructor: (args = {}) ->
    super
    
    for key, value of @args
      @[key] = value
    
    @emit 'construct'
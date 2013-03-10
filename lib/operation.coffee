{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Operation extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
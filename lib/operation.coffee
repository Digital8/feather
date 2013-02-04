{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Operation extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
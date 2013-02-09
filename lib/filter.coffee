{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Filter extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
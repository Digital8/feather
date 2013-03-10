{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Filter extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Tool extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
  
  toJSON: ->
    
    return {
      id: @id
      key: @key
      data: @data
    }
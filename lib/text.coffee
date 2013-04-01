{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Text extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
  
  resize: ({width, height}) ->
    
    @width = width
    @height = height
    
    @emit 'resize'
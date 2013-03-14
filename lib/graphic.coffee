{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Graphic extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @width ?= @image.width
    @height ?= @image.height
    
    @aspect ?= @width / @height
    
    @config = {}
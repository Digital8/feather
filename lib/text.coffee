{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Text extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @color ?= '#BADA55'
    
    @font ?= 'Arial'
    
    @value ?= 'WallCreations'
  
  resize: ({width, height}) ->
    
    @relative.width = width
    @relative.height = height
    
    @emit 'resize'
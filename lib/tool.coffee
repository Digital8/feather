{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Tool extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
  
  deactivate: ->
    
    @kit.editor.filters = @['previous:filters']
    
    @kit.editor.setFilter {}
  
  cache: ->
    @['previous:filters'] ?=
      brightness: '0'
      saturate: '100%'
      'hue-rotate': '0deg'
      contrast: '100%'
    
    for key, value of @kit.editor.filters
      @['previous:filters'][key] = value
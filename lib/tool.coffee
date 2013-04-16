{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Tool extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @kit.editor.on 'slider', (id, value) =>
      
      return unless id is @ui
      
      @emit 'slide', value
  
  commit: ->
  
  deactivate: ->
  
  activate: (tool) ->
{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Project extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
  
  activate: ->
    
    @emit 'activate'
  
  deactivate: ->
    
    # @surface.hide()
    
    @emit 'deactivate'
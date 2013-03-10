{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Project extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
  
  activate: ->
    
    @emit 'activate'
  
  deactivate: ->
    
    # @surface.hide()
    
    @emit 'deactivate'
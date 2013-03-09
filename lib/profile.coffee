{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Profile extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
  
  activate: ->
    
    project = new @projectPrototype
      profile: this
      editor: @editor
    
    @editor.projects.add project
    
    @editor.projects.activate project
    
    @emit 'activate'
  
  deactivate: ->
    
    @editor.projects.deactivate()
    
    @emit 'deactivate'
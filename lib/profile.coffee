{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Profile extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
  
  activate: ->
    @editor.projects.active = @editor.projects.new
      profile: this
      editor: @editor
    
    @emit 'activate'
  
  deactivate: ->
    @emit 'deactivate'
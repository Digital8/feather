{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Project extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
    
    @editor.surfaces.new
      editor: @editor
      width: @profile.width.default
      height: @profile.height.default
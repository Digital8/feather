{EventEmitter} = require 'events'

uuid = require 'node-uuid'

Library = require './core/library'
Graphic = require './graphic'

module.exports = class Project extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @graphics = new Library type: Graphic
    @editor.graphics.on 'add', (graphic) =>
      @graphics.add graphic
  
  activate: ->
    
    @emit 'activate'
  
  deactivate: ->
    
    @emit 'deactivate'
  
  save: ->
    @emit 'save'
  
  load: ->
    @emit 'load'
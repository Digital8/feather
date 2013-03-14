{EventEmitter} = require 'events'

uuid = require 'node-uuid'

Library = require './core/library'
Behaviour =
  Activation: require './core/behaviours/activation'

Project = require './project'

module.exports = class Profile extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @projects = new Library type: @projectPrototype
    Behaviour.Activation @projects
    
    @on 'deactivate', =>
      @projects.deactivate()
  
  activate: ->
    
    @emit 'activate'
  
  deactivate: ->
    
    @emit 'deactivate'
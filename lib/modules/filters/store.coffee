{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Store extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @map ?= (Object.create? null) or {}
    
    @default ?= (Object.create? null) or {}
    unless args.map?
      for key, value of @default
        @map[key] = value
  
  preset: (map) ->
    for key, value of @map
      delete @map[key]
    
    for key, value of @default
      @map[key] = value
    
    for key, value of map
      @map[key] = value
    
    @emit 'preset'
    @emit 'change'
  
  reset: ->
    for key, value of @map
      delete @map[key]
    
    for key, value of @default
      @map[key] = value
      
    @emit 'reset'
    @emit 'change'
  
  set: (key, value) ->
    @map[key] = value
    
    @emit 'change'
  
  mset: (map) ->
    for key, value of map
      @map[key] = value
    
    @emit 'change'
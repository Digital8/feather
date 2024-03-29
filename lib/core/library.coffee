{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Library extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @objects = args.objects
    
    unless @objects?
      
      if Object.create?
        @objects = Object.create null
      else
        @objects = {}
        
        for key, value of @objects
          delete @objects[key]
    
    @type = args.type or Object
    
    @key = args.key or 'id'
  
  map: (callback) ->
    for key, object of @objects
      callback key, object
  
  has: (object) ->
    
    key = object[@key]
    
    @objects[key]?
  
  get: (key) ->
    
    object = @objects[key]
    
    return object
  
  add: (object) ->
    
    return unless object?
    
    object[@key] ?= uuid()
    
    return if @has object
    
    key = object[@key]
    
    @objects[key] = object
    
    @emit 'add', object
  
  remove: (object) ->
    
    return unless @has object
    
    key = object[@key]
    
    delete @objects[key]
    
    @emit 'remove', object
  
  new: ->
    object = new @type arguments...
    
    @add object
    
    return object
  
  clear: ->
    
    for key, object of @objects
      
      @remove object
    
    return
  
  got: (key) ->
    
    return @objects[key]?
  
  unset: (key) ->
    
    return unless @got key
    
    object = @objects[key]
    
    delete @objects[key]
    
    @emit 'remove', object
{EventEmitter} = require 'events'

Library = require './core/library'
Tool = require './tool'

module.exports = class Kit extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @editor = args.editor
    
    @tools = new Library type: Tool, key: 'key'
  
  toJSON: -> @tools.toJSON()
  
  apply: (callback) ->
    active = @active
    
    active?.apply? null
    
    @deactivate()
    
    callback active
  
  cancel: (callback) ->
    active = @active
    
    active?.cancel? null
    
    @deactivate active
    
    callback active
  
  include: (type, defaults = {}) ->
    
    args =
      key: type.name.toLowerCase()
      kit: this
      editor: @editor
    
    if defaults?
      for key, value of defaults
        args[key] = value
    
    instance = new type args
    
    @tools.add instance
    
    return instance
  
  deactivate: (tool) ->
    
    tool?.deactivate? null
    
    active = @active
    @active = null
    
    if active?
      @emit 'deactivate', active
  
  reset: ->
    @deactivate @active
    
    @emit 'reset'
  
  activate: (key, args) ->
    
    return if @active?
    
    unless args?.silent
      if @active?
        @deactivate @active
    
    tool = @tools.get key
    
    if tool?
      
      @active = tool
      
      tool?.activate? key
      
      unless args?.silent? and args.silent
        @emit 'activate', tool
{EventEmitter} = require 'events'

Library = require './core/library'
Tool = require './tool'

module.exports = class Kit extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @editor = args.editor
    
    @tools = new Library type: Tool, key: 'key'
    
    @tools.on 'add', (tool) ->
      console.log 'tool', tool
  
  toJSON: -> @tools.toJSON()
  
  # commit: ->
  #   return unless @active
    
  #   @active.commit? null
    
  #   for key, filter of @active.filters
  #     @editor.filters[key] = filter
  #     @editor.setFilter()
    
  #   @active = null
  
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
    
    console.log 'deactivating'
    
    tool?.deactivate? null
    
    active = @active
    @active = null
    
    if active?
      @emit 'deactivate', tool
  
  reset: ->
    @deactivate @active
    
    @emit 'reset'
  
  activate: (key, args) ->
    
    unless args?.silent
      if @active?
        @deactivate @active
    
    tool = @tools.get key
    
    unless tool?
      console.log 'no', key, 'tool'
      return
    
    @active = tool
    
    tool?.activate? key
    
    unless args?.silent? and args.silent
      @emit 'activate', tool
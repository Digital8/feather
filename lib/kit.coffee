{EventEmitter} = require 'events'

Library = require './library'
Tool = require './tool'

module.exports = class Kit extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @editor = args.editor
    
    @tools = new Library type: Tool, key: 'key'
  
  toJSON: -> @tools.toJSON()
  
  commit: ->
    return unless @active
    
    @active.commit? null
    
    for key, filter of @active.filters
      @editor.filters[key] = filter
      @editor.setFilter()
    
    @active = null
  
  include: (type) ->
    
    instance = new type
      key: type.name.toLowerCase()
      kit: this
      editor: @editor
    
    @tools.add instance
  
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
  
  activate: (key) ->
    @deactivate @active
    
    tool = @tools.get key
    
    console.log
      event: 'active'
      key: key
      tool: tool
    
    @active = tool
    
    tool?.activate? null
    
    @emit 'activate', tool
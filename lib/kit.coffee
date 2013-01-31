{EventEmitter} = require 'events'

Library = require './library'
Tool = require './tool'

module.exports = class Kit extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @editor = args.editor
    
    @tools = new Library type: Tool, key: 'key'
    
    @tools.on 'add', (tool) =>
      tool.editor = @editor
  
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
    
    @tools.add instance
  
  deactivate: (tool) ->
    tool?.deactivate? null
    
    @active = null
    
    @emit 'deactivate', tool
  
  reset: ->
    @deactivate @active
    
    @emit 'reset'
  
  activate: (key) ->
    return if key is @active?.key
    
    # do @reset
    @deactivate @active
    
    tool = @tools.get key
    
    console.log
      event: 'active'
      key: key
      tool: tool
    
    @active = tool
    
    tool?.activate? null
    
    @emit 'activate', tool
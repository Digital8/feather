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
  
  addTool: (type) ->
    
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
    do @reset
    
    tool = @tools.get key
    
    console.log
      event: 'active'
      key: key
      tool: tool
    
    @active = tool
    
    tool?.activate? null
    
    @emit 'activate', tool
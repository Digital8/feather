{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Tool extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
    
    @ui ?= args.ui
    
    @kit.editor.on 'slider', (id, value) =>
      # console.log 'slider', arguments...
      
      return unless id is @ui
      
      @emit 'slide', value
  
  commit: ->
  
  deactivate: ->
    
    @kit.editor.filters = {}
    @kit.editor.setFilter @['previous:filters']
  
  cache: ->
    @['previous:filters'] = {}
    
    for key, value of @kit.editor.filters
      @['previous:filters'][key] = value
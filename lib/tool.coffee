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
      
      return unless id is @ui
      
      @emit 'slide', value
  
  commit: ->
  
  deactivate: ->
    
    @kit.editor.filters = {}
    @kit.editor.setFilter @['previous:filters']
    
    for key, save of @['previous_graphics']
      
      image = @kit.editor.graphics.get key
      
      image.restore save
    
    @['previous_graphics'] = {}
  
  activate: ->
    @['previous:filters'] = {}
    
    for key, value of @kit.editor.filters
      
      @['previous:filters'][key] = value
    
    @['previous_graphics'] ?= {}
    
    for key, graphic of @kit.editor.graphics.objects
      
      save = graphic.save()
      
      @['previous_graphics'][key] = save
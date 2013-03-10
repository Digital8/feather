{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Tool extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @ui ?= args.ui
    
    @kit.editor.on 'slider', (id, value) =>
      
      return unless id is @ui
      
      @emit 'slide', value
    
    @previous =
      filtes: {}
      graphics: {}
  
  commit: ->
  
  deactivate: ->
    
    # reset filters
    @editor.setFilters @previous.filters
    
    # restore graphics
    for key, save of @previous.graphics
      
      graphic = @kit.editor.graphics.get key
      
      continue unless graphic?
      
      graphic.restore save
  
  activate: (tool) ->
    
    # save filters
    @previous.filters = @editor.getFilters()
    
    # save graphics
    @previous.graphics = {}
    for key, graphic of @kit.editor.graphics.objects
      @previous.graphics[key] = graphic.save()
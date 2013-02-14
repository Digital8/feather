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
    
    @previous =
      filtes: {}
      graphics: {}
  
  commit: ->
  
  deactivate: ->
    
    # reset filters
    # @kit.tools.get('filter').set @previous.filters
    
    # restore graphics
    for key, save of @previous.graphics
      
      graphic = @kit.editor.graphics.get key
      
      continue unless graphic?
      
      graphic.restore save
  
  activate: (tool) ->
    
    # save filters
    @previous.filters = {}
    for key, value of @kit.editor.filter
      @previous.filters[key] = value
    
    # save graphics
    @previous.graphics = {}
    for key, graphic of @kit.editor.graphics.objects
      @previous.graphics[key] = graphic.save()
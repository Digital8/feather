Tool = require '../tool'

module.exports = class Filter extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @editor.filter = {}
  
  build: (args = {}) ->
    args.brightness ?= '0'
    args.saturate ?= '100%'
    args['hue-rotate'] ?= '0deg'
    args.contrast ?= '100%'
    args.sepia ?= '0%'
    args.blur ?= '0px'
    
    return args
  
  set: (map = {}) ->
    for key, value of map
      @editor.filter[key] = value
    
    @push()
  
  filter: (map = {}) ->
    @editor.filter = @build map
    
    @push()
  
  reset: ->
    @editor.filter = @build()
    
    @push()
  
  _setGraphicFilters: (graphic, filter) ->
    parts = []
    
    for key, value of filter
      parts.push "#{key}(#{value})"
    
    graphic.dom.find('img').css '-webkit-filter': (parts.join ' ')
    
    graphic.emit 'flush'
  
  push: ->
    for key, graphic of @editor.graphics.objects
      @_setGraphicFilters graphic, @editor.filter
  
  activate: ->
    super
    
    @
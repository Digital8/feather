Tool = require '../tool'

module.exports = class Filter extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @editor.filter = {}
  
  build: (args = {}) ->
    arg =
      sepia: '0%'
      brightness: '0'
      saturate: '100%'
      'hue-rotate': '0deg'
      contrast: '100%'
      blur: '0px'
    
    for key, value of args
      arg[key] = value
    
    return arg
  
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
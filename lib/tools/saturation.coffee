Tool = require '../tool'

module.exports = class Saturation extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @kit.editor.on 'slider', (id, value) =>
      return unless id is 'saturation'
      @emit 'slide', value
  
  activate: ->
    
    @['previous:filters'] ?=
      brightness: '0'
      saturate: '100%'
      'hue-rotate': '0deg'
    
    for key, value of @kit.editor.filters
      @['previous:filters'][key] = value
    
    listener = @on 'slide', (value) =>
      
      for key, graphic of @kit.editor.graphics.objects then do (key, graphic) =>
        graphic.setFilter saturate: "#{value + 100}%"
        graphic.pushFilters()
  
  deactivate: ->
    
    @kit.editor.filters = @['previous:filters']
    
    for key, graphic of @kit.editor.graphics.objects then do (key, graphic) =>
      graphic.pushFilters()
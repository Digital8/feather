Tool = require '../tool'

module.exports = class Temperature extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @kit.editor.on 'slider', (id, value) =>
      return unless id is 'temperature'
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
        graphic.setFilter 'hue-rotate': "#{value * 2}deg"
        graphic.pushFilters()
  
  deactivate: ->
    
    @kit.editor.filters = @['previous:filters']
    
    for key, graphic of @kit.editor.graphics.objects then do (key, graphic) =>
      graphic.pushFilters()
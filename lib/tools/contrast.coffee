Tool = require '../tool'

module.exports = class Contrast extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @kit.editor.on 'slider', (id, value) =>
      return unless id is 'contrast'
      @emit 'slide', value
  
  activate: ->
    
    @['previous:filters'] ?=
      brightness: '0'
      saturate: '100%'
      'hue-rotate': '0deg'
      contrast: '100%'
    
    for key, value of @kit.editor.filters
      @['previous:filters'][key] = value
    
    listener = @on 'slide', (value) =>
      
      for key, graphic of @kit.editor.graphics.objects then do (key, graphic) =>
        if value < 0
          value *= -0.75
          value = 100 - value
        else
          value *= 3.33
        
        console.log value
        
        graphic.setFilter contrast: "#{value}%"
        graphic.pushFilters()
  
  deactivate: ->
    
    @kit.editor.filters = @['previous:filters']
    
    for key, graphic of @kit.editor.graphics.objects then do (key, graphic) =>
      graphic.pushFilters()
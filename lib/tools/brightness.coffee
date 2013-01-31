Tool = require '../tool'

module.exports = class Brightness extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @kit.editor.on 'slider', (id, value) =>
      return unless id is 'brightness'
      @emit 'slide', value
  
  activate: ->
    
    @['previous:filters'] ?=
      brightness: '0'
      saturate: '100%'
      'hue-rotate': '0deg'
    
    for key, value of @kit.editor.filters
      @['previous:filters'][key] = value
    
    @on 'slide', (value) =>
      for key, graphic of @kit.editor.graphics.objects then do (key, graphic) =>
        graphic.setFilter brightness: value / 100
        graphic.pushFilters()
  
  deactivate: ->
    
    console.log 'getting old filters'
    
    console.log @['previous:filters']
    
    @kit.editor.filters = @['previous:filters']
    
    for key, graphic of @kit.editor.graphics.objects then do (key, graphic) =>
      graphic.pushFilters()
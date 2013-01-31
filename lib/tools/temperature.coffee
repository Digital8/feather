Tool = require '../tool'

module.exports = class Temperature extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'temperature'
    
    super
  
  activate: ->
    
    @cache()
    
    listener = @on 'slide', (value) =>
      @kit.editor.setFilter 'hue-rotate': "#{value * 2}deg"
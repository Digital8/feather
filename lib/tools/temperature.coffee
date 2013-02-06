Tool = require '../tool'

module.exports = class Temperature extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'temperature'
    
    super
  
  activate: ->
    
    super
    
    listener = @on 'slide', (value) =>
      
      @kit.editor.setFilter 'hue-rotate': "#{-1 * value / 2}deg"
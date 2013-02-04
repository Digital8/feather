Tool = require '../tool'

module.exports = class Brightness extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'brightness'
    
    super
  
  activate: ->
    
    super
    
    @on 'slide', (value) =>
      
      if value < 0
        value /= 100
        value *= 0.5
      else
        value /= 100
        value *= 0.75
      
      @kit.editor.setFilter brightness: value
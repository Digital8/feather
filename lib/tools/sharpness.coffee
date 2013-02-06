Tool = require '../tool'

module.exports = class Sharpness extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'sharpness'
    
    super
  
  activate: ->
    
    super
    
    @on 'slide', (value) =>
      
      value /= 50
      value *= -1
      
      value *= 5
      
      value = Math.max 0, value
      
      @kit.editor.setFilter blur: "#{value}px"
Tool = require '../tool'

module.exports = class Contrast extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @kit.editor.on 'slider', (id, value) =>
      return unless id is 'contrast'
      @emit 'slide', value
  
  activate: ->
    
    @cache()
    
    listener = @on 'slide', (value) =>
      
      if value < 0
        value *= -0.75
        value = 100 - value
      else
        value *= 3.33
      
      @kit.editor.setFilter contrast: "#{value}%"
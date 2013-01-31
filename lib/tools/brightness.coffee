Tool = require '../tool'

module.exports = class Brightness extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @kit.editor.on 'slider', (id, value) =>
      return unless id is 'brightness'
      @emit 'slide', value
  
  activate: ->
    
    @cache()
    
    @on 'slide', (value) =>
      
      if value < 0
        value /= 100
        value *= 0.5
      else
        value /= 100
        value *= 0.75
      
      @kit.editor.setFilter brightness: value
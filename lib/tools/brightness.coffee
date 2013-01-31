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
      
      @kit.editor.setFilter brightness: value / 100
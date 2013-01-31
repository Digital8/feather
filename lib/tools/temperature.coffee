Tool = require '../tool'

module.exports = class Temperature extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @kit.editor.on 'slider', (id, value) =>
      return unless id is 'temperature'
      @emit 'slide', value
  
  activate: ->
    
    @cache()
    
    listener = @on 'slide', (value) =>
      @kit.editor.setFilter 'hue-rotate': "#{value * 2}deg"
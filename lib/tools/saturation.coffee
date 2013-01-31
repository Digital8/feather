Tool = require '../tool'

module.exports = class Saturation extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @kit.editor.on 'slider', (id, value) =>
      return unless id is 'saturation'
      @emit 'slide', value
  
  activate: ->
    
    @cache()
    
    listener = @on 'slide', (value) =>
      
      @kit.editor.setFilter saturate: "#{value + 100}%"
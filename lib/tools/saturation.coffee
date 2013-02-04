Tool = require '../tool'

module.exports = class Saturation extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'saturation'
    
    super
  
  activate: ->
    
    super
    
    listener = @on 'slide', (value) =>
      
      @kit.editor.setFilter saturate: "#{value + 100}%"
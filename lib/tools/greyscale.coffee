Tool = require '../tool'

module.exports = class Greyscale extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'greyscale'
    
    super
  
  activate: ->
    
    super
    
    @kit.editor.setFilter
      saturate: '12.5%'
      brightness: '-10%'
      contrast: '150%'
Tool = require '../tool'

module.exports = class Singe extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'singe'
    
    super
  
  activate: ->
    
    @cache()
    
    @kit.editor.setFilter
      blur: '0px'
      sepia: '50%'
      brightness: '-10%'
      contrast: '133%'
      saturate: '100%'
      'hue-rotate': '-20deg'
Tool = require '../tool'

module.exports = class Soft extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'soft'
    
    super
  
  activate: ->
    
    @cache()
    
    @kit.editor.setFilter
      blur: '1.5px'
      brightness: '25%'
      contrast: '75%'
      saturate: '75%'
      'hue-rotate': '20deg'
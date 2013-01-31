Tool = require '../tool'

module.exports = class Sepia extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'sepia'
    
    super
  
  activate: ->
    
    @cache()
    
    @kit.editor.setFilter sepia: '75%'
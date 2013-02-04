Tool = require '../tool'

module.exports = class Sepia extends Tool
  
  constructor: (args = {}) ->
    
    @ui = 'sepia'
    
    super
  
  activate: ->
    
    super
    
    @kit.editor.setFilter sepia: '100%'
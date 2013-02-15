Tool = require '../tool'

module.exports = class Crop extends Tool
  
  apply: ->
    
    selected = @editor.selected
    
    @editor.crop selected
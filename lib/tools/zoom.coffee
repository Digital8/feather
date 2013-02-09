Tool = require '../tool'

module.exports = class Zoom extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    zoom = (factor) =>
      
      selected = @editor.augmentations.get('select')?.selected
      
      return unless selected?
      
      selected.zoom ?= 1
      selected.zoom *= factor
      
      oldCenter = [selected.dom.position().left + (selected.dom.width() / 2), selected.dom.position().top + (selected.dom.height() / 2)]
      
      width = selected.clone.width * selected.zoom
      height = selected.clone.height * selected.zoom
      
      selected.dom.css
        width: width
        height: height
      
      selected.dom.css
        left: oldCenter[0] - (width / 2)
        top: oldCenter[1] - (height / 2)
      
      @emit 'zoom'
    
    (jQuery '#zoom-out').click (event) =>
      event.preventDefault()
      zoom 0.9
    
    (jQuery '#zoom-in').click =>
      event.preventDefault()
      zoom 1.1
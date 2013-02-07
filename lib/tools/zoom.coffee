Tool = require '../tool'

module.exports = class Zoom extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    zoom = (factor) =>
      
      selected = @editor.augmentations.get('select')?.selected
      
      return unless selected?
      
      selected.zoom ?= 1
      selected.zoom *= factor
      selected.dom.css zoom: selected.zoom
      
      @emit 'zoom'
      
      # original =
      #   width: attrs.width
      #   height: attrs.height
      
      # attrs.width = attrs.width * scale
      # attrs.height = attrs.height * scale
      
      # delta =
      #   x: original.width - attrs.width
      #   y: original.height - attrs.height
      
      # attrs.x += delta.x / 2
      # attrs.y += delta.y / 2
      
      # @selectedImage.width = attrs.width
      # @selectedImage.height = attrs.height
      
      # console.log 'zoomed'
      
      # @selectedImage.update()
      
      # 
    
    (jQuery '#zoom-out').click (event) =>
      event.preventDefault()
      zoom 0.9
    
    (jQuery '#zoom-in').click =>
      event.preventDefault()
      zoom 1.1
Tool = require '../tool'

module.exports = class Crop extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    @editor.on 'graphic', (graphic) =>
      
      $crop = jQuery """<div>"""
      $crop.css
        width: '100%'
        height: '100%'
        position: 'absolute'
        left: 0
        top: 0
        display: 'none'
      graphic.dom.append $crop
      
      graphic.crop = crop =
        dom: $crop
      
      $container = jQuery """<div>"""
      $container.css
        opacity: 0.33
        width: '100%'
        height: '100%'
        position: 'absolute'
        left: 0
        top: 0
      crop.dom.append $container
      $container.addClass 'crop'
      
      resizable = crop.dom.resizable
        handles: 'all'
        minWidth: 100
        minHeight: 100
        containment: graphic.dom
      
      draggable = crop.dom.draggable
        containment: 'parent'
      
      crop.dom.find('.ui-resizable-handle').addClass 'ui-handle'
      
      graphic.hideCrop = ->
        crop.dom.fadeOut()
        graphic.emit 'hideCrop'
      
      graphic.showCrop = ->
        crop.dom.fadeIn()
        graphic.emit 'showCrop'
      
      graphic.hideCrop()
      
      graphic.crop ?= {}
      
      resizable.on 'resize', (event, ui) =>
        
        graphic.crop.width = ui.size.width
        graphic.crop.height = ui.size.height
        
        graphic.crop.left = $crop.position().left
        graphic.crop.top = $crop.position().top
      
      draggable.on 'drag', (event, ui) =>
        
        graphic.crop.left = $crop.position().left
        graphic.crop.top = $crop.position().top
      
      graphic.on 'select', =>
        return unless @kit.active is this
        graphic.showCrop()
      
      graphic.on 'deselect', =>
        graphic.hideCrop()
  
  activate: ->
    
    super
    
    @editor.augmentations.get('select')?.selected?.showCrop()
  
  deactivate: ->
    
    super
    
    @editor.augmentations.get('select')?.selected?.hideCrop()
  
  commit: ->
    
    super
    
    for key, graphic of @editor.graphics.objects
      
      unless graphic.crop.width? and graphic.crop.height? and graphic.crop.top? and graphic.crop.left?
        
        graphic.hideCrop()
      
      else
        
        url = @editor.operations.get('crop').operate
          width: graphic.crop.width
          height: graphic.crop.height
          
          left: graphic.crop.left
          top: graphic.crop.top
          
          image: graphic.image
        
        graphic.image.src = url
        
        {top, left} = graphic.dom.position()
        
        graphic.dom.css
          left: graphic.crop.left + left
          top: graphic.crop.top + top
          
          width: graphic.crop.width
          height: graphic.crop.height
        
        graphic.crop.dom.css
          left: 0
          top: 0
          
          width: graphic.crop.width
          height: graphic.crop.height
        
        graphic.hideCrop()
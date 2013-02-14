module.exports = (editor) ->
  editor.crop = (graphic) ->
    
    src = editor.operations.crop.operate
      image: image
      
      width: crop.data.width
      height: crop.data.height
      
      left: crop.data.left
      top: crop.data.top
    
    window.open src
  
  editor.on 'graphic', (graphic) ->
    
    buildCrop = ->
      graphic.crop = {}
      graphic.crop.dom = jQuery """<div class="cropper">"""
      graphic.crop.dom.css
        width: '50%'
        height: '50%'
        left: '25%'
        top: '25%'
        position: 'absolute'
        background: 'rgba(0, 0, 0, 0.5)'
        opacity: 1
      graphic.crop.dom.appendTo graphic.dom
      
      # graphic.crop.dom.mousedown (event) ->
      #   event.stopPropagation()
      
      graphic.crop.resizable = graphic.crop.dom.resizable
        handles: 'all'
        minWidth: 100
        minHeight: 100
        containment: graphic.dom
      
      graphic.crop.resizable.on 'resize', (event, ui) =>
      
        graphic.crop.width = ui.size.width
        graphic.crop.height = ui.size.height
        
        graphic.crop.left = graphic.crop.dom.position().left
        graphic.crop.top = graphic.crop.dom.position().top
      
      graphic.crop.draggable = graphic.crop.dom.draggable
        containment: 'parent'
      
      graphic.crop.draggable.on 'drag', (event, ui) =>
        graphic.crop.left = graphic.crop.dom.position().left
        graphic.crop.top = graphic.crop.dom.position().top
      
      graphic.crop.dom.find('.ui-resizable-handle').addClass 'ui-handle'
      
      graphic.crop.dom.find('.ui-resizable-handle').css
        background: "#ffffff url(/css/images/ants.gif)"
      
      graphic.crop.mask = jQuery '<div>'
      graphic.crop.mask.css
        width: '100%'
        height: '100%'
        left: 0
        top: 0
        position: 'absolute'
        background: 'black'
        opacity: 0.25
      graphic.crop.mask.appendTo graphic.dom
      graphic.crop.mask.hide()
      
      graphic.crop.show = ->
        graphic.crop ?= buildCrop()
        
        graphic.crop.dom.fadeIn()
        graphic.crop.mask.fadeIn()
      
      graphic.crop.hide = ->
        graphic.crop.dom.fadeOut()
        graphic.crop.dom.remove()
        graphic.crop.mask.fadeOut()
        graphic.crop = {}
      
      return graphic.crop
    
    graphic.on 'select', =>
      return unless editor.kit.active?.key is 'crop'
      graphic.crop = buildCrop()
      graphic.crop.show()
    
    graphic.on 'deselect', =>
      graphic.crop?.hide()
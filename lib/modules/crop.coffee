Surface = require '../surface'

module.exports = (editor) ->
  
  editor.crop = (graphic) ->
    
    {width, height, left, top} = graphic._crop
    
    src = editor.operations.crop.operate
      image: graphic.image
      
      width: width
      height: height
      
      left: left
      top: top
    
    # window.open src
    graphic.image.src = src
    
    position = graphic.dom.position()
    
    graphic.dom.css width: width, height: height
    graphic.dom.css left: position.left + left, top: position.top + top
    
  editor.on 'graphic', (graphic) ->
    
    graphic.croppable = (args) ->
      
      if not args?
        
        masks = jQuery """<div>"""
        masks.css
          width: '100%'
          height: '100%'
          left: 0
          top: 0
          position: 'absolute'
          opacity: 0.33
        masks.appendTo graphic.dom
        
        dom = jQuery """<div>"""
        dom.css
          width: '75%'
          height: '75%'
          left: '12.5%'
          top: '12.5%'
          position: 'absolute'
        dom.appendTo graphic.dom
        
        updateMasks = ->
          width = dom.width()
          height = dom.height()
          
          position = dom.position()
          
          graphic._crop.left = position.left
          graphic._crop.top = position.top
          graphic._crop.width = width
          graphic._crop.height = height
          
          (masks.data 'top').css height: position.top, top: 0, width: '100%'
          (masks.data 'bottom').css height: graphic.dom.height() - (position.top + height), bottom: 0, width: '100%'
          (masks.data 'left').css height: '100%', left: 0, top: 0, width: position.left
          (masks.data 'right').css height: '100%', right: 0, top: 0, width: graphic.dom.width() - (position.left + width)
        
        resizable = dom.resizable
          handles: 'all'
          minWidth: 100
          minHeight: 100
          containment: graphic.dom
          resize: -> updateMasks()
        
        draggable = dom.draggable
          containment: graphic.dom
          drag: -> updateMasks()
        
        graphic._crop ?= {}
        graphic._crop.dom = dom
        graphic._crop.draggable = draggable
        graphic._crop.resizable = resizable
        
        graphic._crop.masks = masks
        
        spawn = (key) ->
          mask = jQuery """<div>"""
          mask.css
            position: 'absolute'
            background: 'black'
          mask.appendTo masks
          masks.data key, mask
        
        spawn key for key in ['top',  'left', 'right', 'bottom']
        
        updateMasks()
        
        graphic.dom.find('.ui-resizable-handle').addClass 'ui-handle'
      
      if args is 'destroy'
        
        return unless graphic._crop?
        
        graphic._crop.dom.resizable 'destroy'
        graphic._crop.dom.draggable 'destroy'
        graphic._crop.dom.remove()
        graphic._crop.masks.remove()
        
        delete graphic._crop
    
    graphic.on 'select', ->
      return unless editor.kit.active?.key is 'crop'
      graphic.croppable()
    
    graphic.on 'deselect', ->
      graphic.croppable 'destroy'
  
  editor.kit.on 'activate', ({key}) ->
    return unless key is 'crop'
    editor.selected?.croppable()
  
  editor.kit.on 'deactivate', ({key}) ->
    editor.selected?.croppable 'destroy'
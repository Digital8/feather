module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    graphic.crop = ({viewport, bounds}) ->
      
      graphic.data.crop = viewport: viewport
      
      left = viewport.left * graphic.initial.width
      top = viewport.top * graphic.initial.height
      width = viewport.width * graphic.initial.width
      height = viewport.height * graphic.initial.height
      
      src = editor.operations.crop.operate
        image: graphic.clone
        
        left: left
        top: top
        width: width
        height: height
      
      graphic.dom.css
        left: graphic.dom.position().left + (viewport.left * graphic.initial.width * graphic.scale[0])
        top: graphic.dom.position().top + (viewport.top * graphic.initial.height * graphic.scale[1])
        width: graphic.scale[0] * width
        height: graphic.scale[1] * height
      
      graphic.image.src = src
    
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
        
        handleCrop = ->
          
          editor.kit.active.data =
            bounds: graphic._crop.getBounds()
            viewport: graphic._crop.getViewport()
          
          updateMasks()
        
        resizable = dom.resizable
          handles: 'all'
          minWidth: 100
          minHeight: 100
          containment: graphic.dom
          resize: -> handleCrop()
        
        draggable = dom.draggable
          containment: graphic.dom
          drag: -> handleCrop()
        
        graphic._crop ?= {}
        graphic._crop.dom = dom
        graphic._crop.draggable = draggable
        graphic._crop.resizable = resizable
        
        graphic._crop.restore = (save) ->
          dom.css save
        
        graphic._crop.getBounds = ->
          return {
            left: dom.position().left
            top: dom.position().top
            width: dom.width()
            height: dom.height()
          }
        
        graphic._crop.getViewport = ->
          
          absolute = graphic._crop.getBounds()
          
          relative =
            left: absolute.left / graphic.dom.width()
            top: absolute.top / graphic.dom.height()
            width: absolute.width / graphic.dom.width()
            height: absolute.height / graphic.dom.height()
          
          return relative
        
        graphic._crop.masks = masks
        
        spawn = (key) ->
          mask = jQuery """<div>"""
          mask.css
            position: 'absolute'
            background: 'black'
          mask.appendTo masks
          masks.data key, mask
        
        spawn key for key in ['top',  'left', 'right', 'bottom']
        
        graphic.dom.find('.ui-resizable-handle').addClass 'ui-handle'
        
        if graphic.data.crop?
          
          console.log 'restoring crop'
          
          {viewport} = graphic.data.crop
          
          image =
            width: graphic.initial.width * graphic.scale[0]
            height: graphic.initial.height * graphic.scale[1]
            left: graphic.dom.position().left - (viewport.left * graphic.initial.width * graphic.scale[0])
            top: graphic.dom.position().top - (viewport.top * graphic.initial.height * graphic.scale[1])
          
          graphic.dom.css image
          
          graphic.image.src = graphic.clone.src
          
          crop =
            left: viewport.left * image.width
            top: viewport.top * image.height
            width: viewport.width * image.width
            height: viewport.height * image.height
          
          graphic._crop.dom.css crop
        
        handleCrop()
      
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
  
  editor.on 'apply', ({key, data}) ->
    return unless key is 'crop'
    
    editor.selected?.crop data
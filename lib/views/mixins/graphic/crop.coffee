{Mask} = require 'feather'
util = require 'util'

module.exports = (graphicController) ->
  
  {graphic, editor, view, slotController} = graphicController
  
  {slot} = graphic
  
  croppable = (graphicController) ->
    
    unless args?
      
      handleCrop = null
      
      dom = jQuery """<div>"""
      dom.css
        width: '75%'
        height: '75%'
        left: '12.5%'
        top: '12.5%'
        position: 'absolute'
        'z-index': 90
      dom.appendTo view.dom
      
      draggable = dom.draggable
        containment: view.dom.find('img')
        drag: -> handleCrop()
        stop: -> handleCrop()
      
      resizable = dom.resizable
        handles: 'all'
        minWidth: 100
        minHeight: 100
        containment: view.dom
        resize: -> handleCrop()
      
      view.dom.find('.ui-resizable-handle').addClass 'ui-handle'
      
      $masks = jQuery '<div>'
      $masks.appendTo view.dom
      $masks.css
        opacity: 0.5
        position: 'absolute'
        left: 0
        top: 0
        width: '100%'
        height: '100%'
      
      masks = {}
      
      for key in ['left', 'bottom', 'right', 'top']
        mask = jQuery '<div>'
        mask.appendTo $masks
        mask.css
          position: 'absolute'
          background: 'black'
        masks[key] = mask
      
      data = {}
      
      handleCrop = ->
        
        data.left = dom.position().left / view.dom.width()
        data.top  = dom.position().top  / view.dom.height()
        data.width  = dom.width() / view.dom.width()
        data.height = dom.height() / view.dom.height()
        
        masks.top.css height: dom.position().top, top: 0, width: '100%', left: 0
        masks.bottom.css height: view.dom.height() - (dom.position().top + dom.height()), bottom: 0, width: '100%'
        masks.left.css height: '100%', left: 0, top: 0, width: dom.position().left
        masks.right.css height: '100%', right: 0, top: 0, width: view.dom.width() - (dom.position().left + dom.width())
      
      handleCrop()
      
      return {
        data: data
        resizable: resizable
        draggable: draggable
        destroy: ->
          draggable.draggable 'destroy'
          resizable.resizable 'destroy'
          $masks.remove()
      }
  
  editor.on 'apply', ({key}) ->
    
    if key is 'crop'
      {data} = graphicController.croppable
      
      {top, left, width, height} = data
      
      bottom = 1 - (top + height)
      right = 1 - (left + width)
      
      if graphic.filters.flipv
        data.top = bottom
      
      if graphic.filters.fliph
        data.left = right
      
      if graphic.filters.rotate is (Math.PI / 2)
        
        realRight = right
        realTop = top
        
        if graphic.filters.fliph
          realRight = left
        if graphic.filters.flipv
          realTop = bottom
        
        [data.top, data.left, data.width, data.height] = [realRight, realTop, height, width]
      
      if graphic.filters.rotate is (Math.PI)
        realBottom = bottom
        realRight = right
        if graphic.filters.fliph
          realRight = left
        if graphic.filters.flipv
          realBottom = top
        [data.top, data.left] = [realBottom, realRight]
      
      if graphic.filters.rotate is (3 * Math.PI / 2)
        realBottom = bottom
        realLeft = left
        if graphic.filters.fliph
          realLeft = right
        if graphic.filters.flipv
          realBottom = top
        [data.top, data.left, data.width, data.height] = [realLeft, realBottom , height, width]
      
      graphic.filters.crop ?= left: 0, top: 0, width: 1, height: 1
      
      cropMappedToImage =
        left: graphic.filters.crop.left * graphic.image.width
        top: graphic.filters.crop.top * graphic.image.height
        width: graphic.filters.crop.width * graphic.image.width
        height: graphic.filters.crop.height * graphic.image.height
      
      cropMapped =
        left: data.left * cropMappedToImage.width
        top: data.top * cropMappedToImage.height
        width: data.width * cropMappedToImage.width
        height: data.height * cropMappedToImage.height
      
      cropAbs =
        left: cropMappedToImage.left + cropMapped.left
        top: cropMappedToImage.top + cropMapped.top
        width: cropMapped.width
        height: cropMapped.height
      
      graphic.filters.crop =
        left: cropAbs.left / graphic.image.width
        top: cropAbs.top / graphic.image.height
        width: cropAbs.width / graphic.image.width
        height: cropAbs.height / graphic.image.height
      
      graphic.relative =
        width: data.width * view.dom.width() / slotController.view.dom.width()
        height: data.height * view.dom.height() / slotController.view.dom.height()
      
      graphic.offset =
        left: (view.dom.position().left + (left  * view.dom.width()))  / slotController.view.dom.width()
        top:  (view.dom.position().top  + (top * view.dom.height())) / slotController.view.dom.height()
      
      graphic.emit 'move'
      graphic.emit 'resize'
      
      slot.filters.emit 'change'
  
  graphic.on 'activate', ->
    if editor.kit.active?.key is 'crop'
      graphicController.croppable = croppable graphicController
  
  graphic.on 'deactivate', ->
    if editor.kit.active?.key is 'crop'
      graphicController.croppable.destroy()
  
  editor.kit.on 'activate', ({key}) ->
    if key is 'crop'
      if graphic.slot.graphics.active is graphic
        graphicController.croppable = croppable graphicController
  
  editor.kit.on 'deactivate', ({key}) ->
    if key is 'crop'
      if graphic.slot.graphics.active is graphic
        graphicController.croppable.destroy()
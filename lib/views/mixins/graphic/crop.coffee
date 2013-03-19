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
      
      # debug = jQuery '<p>'
      # debug.css color: 'white'
      # debug.appendTo dom
      
      handleCrop = ->
        
        data.left = dom.position().left / view.dom.width()
        data.top  = dom.position().top  / view.dom.height()
        data.width  = dom.width() / view.dom.width()
        data.height = dom.height() / view.dom.height()
        
        masks.top.css height: dom.position().top, top: 0, width: '100%', left: 0
        masks.bottom.css height: view.dom.height() - (dom.position().top + dom.height()), bottom: 0, width: '100%'
        masks.left.css height: '100%', left: 0, top: 0, width: dom.position().left
        masks.right.css height: '100%', right: 0, top: 0, width: view.dom.width() - (dom.position().left + dom.width())
        
        # debug.html """
        #   <p>left: #{dom.position().left}</p>
        #   <p>top: #{dom.position().top}</p>
        #   <p>width: #{dom.width()}</p>
        #   <p>height: #{dom.height()}</p>
        #   <p>data: #{JSON.stringify data}</p>
        # """
      
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
      
      if (graphic.filters.rotate isnt 0) and (graphic.filters.rotate isnt Math.PI)
        return
      
      {data} = graphicController.croppable
      
      {top, left, width, height} = data
      
      # this is the muntedness
      # abs =
      #   left: left * view.dom.width()
      #   top: top * view.dom.height()
      #   width: width * view.dom.width()
      #   height: height * view.dom.height()
      
      # abs.right = view.dom.width() - (abs.left + abs.width)
      # abs.bottom = view.dom.height() - (abs.top + abs.height)
      
      # if graphic.filters.rotate is Math.PI / 2
      #   console.log 'munting the hax'
      #   [abs.top, abs.right, abs.bottom, abs.left] = [abs.right, abs.bottom, abs.left, abs.top]
        
      #   data.left = abs.left / view.dom.width()
      #   data.top = abs.top / view.dom.height()
      #   data.width = abs.width / view.dom.width()
      #   data.height = abs.height / view.dom.height()
      #   data.right = abs.right / view.dom.width()
      #   data.bottom = abs.bottom / view.dom.height()
        
      #   left = data.left
      #   top = data.top
      # </muntedness>
      
      bottom = 1 - (top + height)
      right = 1 - (left + width)
      
      if graphic.filters.flipv ^ graphic.filters.rotate is Math.PI
        data.top = bottom
        console.log 'munted flipv'
      
      if graphic.filters.fliph ^ graphic.filters.rotate is Math.PI
        data.left = right
        console.log 'munted fliph'
      
      # if graphic.filters.rotate is Math.PI
      #   data.left = right
      #   data.top = bottom
      
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
      
      # # {top, left, width, height} = data
      # # bottom = 1 - (top + height)
      # # right = 1 - (left + width)
      
      # # if graphic.filters.flipv
      # #   console.log 'munting flipv'
      # #   data.top = bottom
      # # if graphic.filters.fliph
      # #   console.log 'munting fliph'
      # #   data.left = right
      
      graphic.relative =
        width: data.width * view.dom.width() / slotController.view.dom.width()
        height: data.height * view.dom.height() / slotController.view.dom.height()
      
      graphic.offset =
        left: (view.dom.position().left + (left  * view.dom.width()))  / slotController.view.dom.width()
        top:  (view.dom.position().top  + (top * view.dom.height())) / slotController.view.dom.height()
      
      graphic.emit 'move'
      graphic.emit 'resize'
      
      # graphic.filters.crop = data
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
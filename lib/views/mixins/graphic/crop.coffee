{Mask} = require 'feather'

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
      
      handleCrop = ->
        masks.top.css height: dom.position().top, top: 0, width: '100%', left: 0
        masks.bottom.css height: view.dom.height() - (dom.position().top + dom.height()), bottom: 0, width: '100%'
        masks.left.css height: '100%', left: 0, top: 0, width: dom.position().left
        masks.right.css height: '100%', right: 0, top: 0, width: view.dom.width() - (dom.position().left + dom.width())
      
      handleCrop()
      
      return {
        croppable:
          resizable: resizable
          draggable: draggable
        destroy: ->
          draggable.draggable 'destroy'
          resizable.resizable 'destroy'
          $masks.remove()
      }
  
  editor.on 'apply', ({key}) ->
    if key is 'crop'
      # graphic.relative = {}
      # width: 
      graphic.filters.crop =
        left: 0.125
        top: 0.124
        width: 0.75
        height: 0.75
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
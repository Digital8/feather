{EventEmitter} = require 'events'

module.exports = class Crop extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->

Crop.augment = (editor) ->
  
  editor.on 'graphic', (graphic) =>
    
    $crop = jQuery """<div>"""
    $crop.css
      # background: 'white'
      opacity: 0.33
      width: '100%'
      height: '100%'
      position: 'absolute'
      left: 0
      top: 0
      display: 'none'
    graphic.dom.append $crop
    
    $crop.addClass 'crop'
    
    $crop.resizable
      handles: 'all'
      minWidth: 100
      minHeight: 100
    
    graphic.crop = $crop.draggable
      containment: 'parent'
    
    # graphic.original =
    #   width: graphic.dom.width()
    #   height: graphic.dom.height()
    
    graphic.element.css
      width: graphic.dom.width()
      height: graphic.dom.height()
    
    $crop.find('.ui-resizable-handle').addClass 'ui-handle'
    
    graphic.hideCrop = ->
      graphic.element.css '-webkit-filter': 'brightness(0%)'
      $crop.fadeOut()
    
    graphic.showCrop = ->
      graphic.element.css '-webkit-filter': 'brightness(-25%)'
      $crop.fadeIn()
    
    if editor.kit.active?.key is 'crop'
      console.log 'keeping crop since crop is active'
    else
      graphic.hideCrop()
    
    graphic.crop.on 'resizestop', (event, ui) =>
      
      graphic.size = ui.size
      
      graphic.position = ui.position
      
      console.log
        top: graphic.position.top
        left: graphic.position.left
        width: graphic.size.width
        height: graphic.size.height
      
      console.log
        position_left: graphic.dom.position().left
        position_top: graphic.dom.position().top
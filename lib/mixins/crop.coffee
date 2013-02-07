{EventEmitter} = require 'events'

module.exports = class Crop extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->

Crop.augment = (editor) ->
  
  editor.on 'graphic', (graphic) =>
    
    $crop = jQuery """<div>"""
    $crop.css
      opacity: 0.33
      width: '100%'
      height: '100%'
      position: 'absolute'
      left: 0
      top: 0
      display: 'none'
    graphic.dom.append $crop
    
    graphic.$crop = $crop
    
    $crop.addClass 'crop'
    
    resizable = $crop.resizable
      handles: 'all'
      minWidth: 100
      minHeight: 100
      containment: graphic.dom
    
    draggable = $crop.draggable
      containment: 'parent'
    
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
    
    graphic.crop ?= {}
    
    resizable.on 'resize', (event, ui) =>
      
      graphic.crop.width = ui.size.width
      graphic.crop.height = ui.size.height
      
      graphic.crop.left = $crop.position().left
      graphic.crop.top = $crop.position().top
    
    draggable.on 'drag', (event, ui) =>
      
      graphic.crop.left = $crop.position().left
      graphic.crop.top = $crop.position().top
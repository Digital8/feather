{EventEmitter} = require 'events'

module.exports = class Select extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->
    

Select.augment = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    console.log 'selectizing'
    
    graphic.dom.mousedown (event) ->
      
      console.log 'mousedown'
      
      $deleteButton = jQuery """<div>"""
      $deleteButton.css
        background: 'red'
        width: 20
        height: 20
        top: -10
        right: -10
        position: 'absolute'
        'line-height': 20
        'font-size': 20
      graphic.dom.append $deleteButton
      
      $deleteButton.mousedown (event) ->
        
        graphic.emit 'delete'
      
      return
    
    graphic.on 'delete', =>
      
      graphic.dom.remove()
  
  augmentation =
    zIndex: 0
  
  return augmentation
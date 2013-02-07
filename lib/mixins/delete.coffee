{EventEmitter} = require 'events'

module.exports = class Delete extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->
    

Delete.augment = (editor) ->
  
  editor.on 'graphic', (graphic) =>
    
    $deleteButton = jQuery """<div>"""
    
    $deleteButton.css
      width: 20
      height: 20
      top: -10
      right: -10
      position: 'absolute'
      'line-height': 20
      'font-size': 20
    graphic.dom.append $deleteButton
    
    $deleteButton.addClass 'ui-handle-delete'
    
    $deleteButton.mousedown (event) ->
      
      graphic.emit 'delete'
    
    graphic.hideDeleteButton = ->
      $deleteButton.hide()
    
    graphic.showDeleteButton = ->
      $deleteButton.show()
    
    graphic.on 'delete', =>
      
      graphic.dom.remove()
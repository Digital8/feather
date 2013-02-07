{EventEmitter} = require 'events'

module.exports = class Scale extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->
    

Scale.augment = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    graphic.hideHandles = ->
      graphic.handles.fadeOut 'swift'
    
    graphic.showHandles = ->
      graphic.handles.fadeIn 'swift'
    
    # save the graphic's container
    graphic.container = graphic.dom
    
    graphic.dom.resizable
      handles: 'all'
      minWidth: 100
      minHeight: 100
    
    graphic.handles = graphic.dom.find '> .ui-resizable-handle'
    
    graphic.handles.hide()
    
    graphic.dom.hide()
    graphic.dom.fadeIn()
    
    graphic.handles.addClass 'ui-handle'
    
    graphic.dom.css overflow: 'visible'
{EventEmitter} = require 'events'

module.exports = class Scale extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->
    

Scale.augment = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    console.log 'scalizing'
    
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
    
    graphic.handles = graphic.dom.find '.ui-resizable-handle'
    
    graphic.handles.addClass 'ui-handle'
    
    graphic.hideHandles()
    
    graphic.dom.css overflow: 'visible'
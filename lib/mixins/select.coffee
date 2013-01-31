{EventEmitter} = require 'events'

module.exports = class Select extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->
    

Select.augment = (editor) ->
  # {stage} = editor.ui
  # stage.mousedown ->
  #   handles = stage.find '.ui-resizable-handle'
  #   handles.fadeOut 'swift'
  
  augmentation =
    zIndex: 0
  
  editor.on 'graphic', (graphic) ->
    
    console.log 'selectizing'
    
    graphic.dom.mousedown (event) ->
    
      graphic.dom.css zIndex: ++augmentation.zIndex
  
  return augmentation
{EventEmitter} = require 'events'

module.exports = class Select extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->
    

Select.augment = (editor) ->
  
  augmentation =
    zIndex: 0
    selected: null
  
  augmentation.deselect = (graphic) ->
    
    return unless augmentation.selected?
    
    selected = augmentation.selected
    
    delete augmentation.selected
    
    selected.hideSelection()
    
    selected.emit 'deselect'
  
  augmentation.select = (graphic) ->
    
    augmentation.deselect()
    
    augmentation.selected = graphic
    
    graphic.showSelection()
    
    graphic.emit 'select'
  
  editor.ui.stage.click =>
    augmentation.deselect()
  
  editor.on 'graphic', (graphic) ->
    
    graphic.bringToTop = ->
      augmentation.zIndex++
      
      graphic.dom.css 'z-index': augmentation.zIndex
    
    graphic.hideSelection = ->
      graphic.dom.css 'box-shadow': ''
    
    graphic.showSelection = ->
      graphic.dom.css 'box-shadow': '0px 0px 0px 3px #8ac53f'
    
    graphic.select = ->
      augmentation.select graphic
    
    graphic.deselect = ->
      augmentation.deselect graphic
    
    graphic.dom.mousedown (event) ->
      graphic.select()
    
    graphic.on 'select', ->
      graphic.bringToTop()
  
  return augmentation
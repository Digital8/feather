{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Graphic extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @id = args.id or uuid()
    
    @dom = jQuery """<div>"""
    @dom.css
      position: 'absolute'
      left: 0
      top: 0
    
    @element = jQuery args.image
    @element.appendTo @dom
    
    @image = args.image
    
    @clone = new Image
    @clone.src = @image.src
    
    @element.css
      width: '100%'
      height: '100%'
    
    @dom.css
      width: @image.width
      height: @image.height
    
    @element.addClass 'feather-graphic'
    
    @element.hide()
    
    @element.fadeIn()
    
    @editor = args.editor
  
  save: ->
    
    return {
      css:
        width: @dom.width()
        height: @dom.height()
        left: @dom.position().left
        top: @dom.position().top
      src: @image.src
    }
  
  restore: (save) ->
    
    @dom.css save.css
    @image.src = save.src
  
  remove: ->
    @dom.fadeOut()
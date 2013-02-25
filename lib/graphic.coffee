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
    
    @dom._css = @dom.css
    @dom.css = =>
      console.log 'css', arguments
      @dom._css arguments...
    
    @element.addClass 'feather-graphic'
    
    @element.hide()
    
    @element.fadeIn()
    
    @editor = args.editor
    
    @data = {}
    
    @remember()
  
  remember: ->
    
    @initial ?= {}
    @initial.width = @image.width
    @initial.height = @image.height
    
    @viewport ?= {}
    @viewport.left = 0
    @viewport.top = 0
    @viewport.width = 1
    @viewport.height = 1
    
    @scale = [1, 1]
  
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
    
    if save.src?
      @image.src = save.src
  
  remove: ->
    @dom.fadeOut()
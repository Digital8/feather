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
      right: 0
      # width: '100%'
      # height: '100%'
    
    @element = jQuery args.image
    @element.appendTo @dom
    
    @image = args.image
    
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
  
  pushFilters: ->
    val = ''
    
    for key, value of @editor.filters
      val += "#{key}(#{value}) "
    
    @element.css '-webkit-filter': val
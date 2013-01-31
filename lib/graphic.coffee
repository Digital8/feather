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
      width: '100%'
      height: '100%'
    
    @element = args.dom
    @element.appendTo @dom
    
    @element.css
      width: '100%'
      height: '100%'
    
    @element.addClass 'feather-graphic'
    
    @element.hide()
    
    @element.fadeIn()
    
    @editor = args.editor
    
    @setFilter()
  
  setFilter: (map = {}) ->
    @editor.filters ?= {}
    
    for key, value of map
      @editor.filters[key] = value
  
  pushFilters: ->
    val = ''
    
    for key, value of @editor.filters
      val += "#{key}(#{value}) "
    
    @element.css '-webkit-filter': val
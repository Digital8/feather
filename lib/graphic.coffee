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
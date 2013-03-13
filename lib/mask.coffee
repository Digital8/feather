{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Mask extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @id ?= uuid()
    
    @build()
    @push()
    
    @dom.append @child
    @child.css
      border: '3px dashed'
      'border-color': 'rgb(180, 235, 250)'
    
    @controller.on 'hide', =>
      @hide()
  
  hide: ->
    @dom.hide()
    @emit 'hide'
  
  show: ->
    @dom.show()
    @emit 'show'
  
  build: ->
    
    @dom = jQuery """<div>"""
    @dom.css
      position: 'absolute'
      left: 0
      top: 0
      width: '100%'
      height: '100%'
    @dom.appendTo @parent
    
    @mask = jQuery '<div>'
    
    @mask.css
      position: 'absolute'
      left: 0
      top: 0
      width: '100%'
      height: '100%'
      opacity: 0.2
      '-webkit-pointer-events': 'none'
      'pointer-events': 'none'
      zIndex: 1000000000000
    
    @dom.append @mask
    
    spawn = (key) =>
      element = jQuery """<div>"""
      element.css
        position: 'absolute'
        background: 'black'
      @mask.append element
      
      @masks ?= {}
      @masks[key] = element
    
    for key in ['top', 'left', 'right', 'bottom']
      spawn key
  
  push: ->
    @masks.top.css height: @margin.y, top: 0, width: '100%'
    @masks.bottom.css height: @margin.y, bottom: 0, width: '100%'
    @masks.left.css width: @margin.x, left: 0, height: '100%'
    @masks.right.css width: @margin.x, right: 0, height: '100%'
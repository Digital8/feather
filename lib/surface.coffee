{EventEmitter} = require 'events'

uuid = require 'node-uuid'

module.exports = class Surface extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    for key, value of args
      
      @[key] = value
    
    @id ?= uuid()
    
    @width ?= 0
    @height ?= 0
    
    @build()
    
    @on 'update', => @push()
    
    @setSize @width, @height
    
    @editor.on 'ui', (key, value) =>
      if key is 'width'
        @setSize value, @height
      if key is 'height'
        @setSize @width, value
  
  setSize: (width, height) ->
    
    @width = width
    @height = height
    
    @aspect = @width / @height
    
    @update()
    
    @editor.emit 'resize', @width, @height
  
  build: ->
    
    @dom = jQuery """<div>"""
    @dom.attr 'id', 'wrapper'
    @dom.css
      position: 'absolute'
      left: 0
      top: 0
      width: '100%'
      height: '100%'
    @dom.appendTo @editor.ui.stage
    
    @mask = jQuery """<div>"""
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
    
    @element = jQuery """<div>"""
    @element.attr 'id', 'surface'
    @element.css
      position: 'absolute'
      left: 0
      top: 0
      width: '100%'
      height: '100%'
      border: '3px dashed'
      'border-color': 'rgb(180, 235, 250)'
    @dom.append @element
    
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
  
  update: ->
    
    minMargin = 20
    
    @margin = {x: 0, y: 0}
    
    {stage} = @editor
    
    if @aspect > stage.aspect
      @margin.x = Math.floor minMargin * stage.aspect
      scale = @width / (stage.width - 2 * @margin.x)
      newHeight = @height / scale
      @margin.y = Math.floor (stage.height - newHeight) / 2
    else
      @margin.y = minMargin
      scale = @height / (stage.height - 2 * @margin.y)
      newWidth = @width / scale
      @margin.x = Math.floor (stage.width - newWidth) / 2
    
    @data =
      top: @margin.y
      left: @margin.x
      width: stage.width - (2 * @margin.x)
      height: stage.height - (2 * @margin.y)
    
    @emit 'update'
  
  push: ->
    @masks.top.css height: @margin.y, top: 0, width: '100%'
    @masks.bottom.css height: @margin.y, bottom: 0, width: '100%'
    @masks.left.css width: @margin.x, left: 0, height: '100%'
    @masks.right.css width: @margin.x, right: 0, height: '100%'
    
    @element.css @data
  
  hide: ->
    
    @dom.fadeOut()
  
  show: ->
    
    @dom.fadeIn()
{EventEmitter} = require 'events'

module.exports = class Surface extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @editor = args.editor
    
    @width = 750
    @height = 500
    @aspect = @width / @height
    
    @wrapper = jQuery """<div>"""
    @wrapper.css
      position: 'absolute'
      left: 0
      top: 0
      width: '100%'
      height: '100%'
      # background: 'black'
    (jQuery '#stage').append @wrapper
    
    @elementsElement = jQuery """<div>"""
    @elementsElement.css
      position: 'absolute'
      left: 0
      top: 0
      width: '100%'
      height: '100%'
      opacity: 0.2
      # background: 'black'
      '-webkit-pointer-events': 'none'
      'pointer-events': 'none'
      zIndex: 1000000000000
    @wrapper.append @elementsElement
    
    @element = jQuery """<div>"""
    @element.attr id: 'surface'
    @element.css
      position: 'absolute'
      left: 0
      top: 0
      width: '100%'
      height: '100%'
      # opacity: 0.2
      # background: 'red'
      border: '3px dashed'
      'border-color': 'rgb(180, 235, 250)'
    @wrapper.append @element
    
    spawn = (key) =>
      element = jQuery """<div>"""
      element.css
        position: 'absolute'
        # opacity: 0.33
        background: 'black'
      @elementsElement.append element
      
      @elements ?= {}
      @elements[key] = element
    
    for key in ['top', 'left', 'right', 'bottom']
      spawn key
    
    # update = =>
    #   @update Math.random() * 1000, Math.random() * 1000
    #   setTimeout update, Math.random() * 333
    # update()
    
    @editor.on 'size', (key, value) =>
      @[key] = value
      @editor.emit 'resize'
    
    @on 'update', => @push()
    
    @update()
    
    @editor.on 'resize', => @update()
  
  update: (x, y) ->
    
    baseMargin = 20
    
    margin = {x: null, y: null}
    
    # @width = x
    # @height = y
    
    @aspect = @width / @height
    
    {stage} = @editor
    # stage.aspect = stage.width / stage.height
    
    if @aspect > stage.aspect
      margin.x = Math.floor baseMargin * stage.aspect
      scale = @width / (stage.width - 2 * margin.x)
      newHeight = @height / scale
      margin.y = Math.floor (stage.height - newHeight) / 2
    else
      margin.y = baseMargin
      scale = @height / (stage.height - 2 * margin.y)
      newWidth = @width / scale
      margin.x = Math.floor (stage.width - newWidth) / 2
    
    @data =
      top: margin.y
      left: margin.x
      width: stage.width - (2 * margin.x)
      height: stage.height - (2 * margin.y)
    
    @margin =
      x: margin.x
      y: margin.y
    
    @emit 'update'
  
  push: ->
    
    @elements.top.css height: @margin.y, top: 0, width: '100%'
    @elements.bottom.css height: @margin.y, bottom: 0, width: '100%'
    @elements.left.css width: @margin.x, left: 0, height: '100%'
    @elements.right.css width: @margin.x, right: 0, height: '100%'
    
    @element.css @data
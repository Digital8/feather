{EventEmitter} = require 'events'

Slot = require './slot'

module.exports = class Layout extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @dom = jQuery """<div>"""
    
    @dom.appendTo @editor.surface.element
    
    @dom.css
      width: @template.width / 5
      height: @template.height / 5
      background: "url(/css/images/masks/#{@template.mask})"
      'background-size': 'contain'
      # 'background: 
    @dom.draggable()
    
    # zoom = 1
    # @dom.on 'mousewheel', (event) =>
    #   {originalEvent} = event
    
    #   val = originalEvent.wheelDelta
    #   if 0 < val
    #     zoom *= 1.1
    #   else if val < 0
    #     zoom *= 0.9
    
    #   event.preventDefault()
    
    #   @dom.css zoom: zoom
    
    for _slot in @template.data
      
      slot = new Slot
        x: _slot.x
        y: _slot.y
        width: _slot.width
        height: _slot.height
        dom: @dom
        editor: @editor
        template: @template
      # slot.dom.appendTo editor.surface.element
    
    clone = @dom.clone()
    clone.appendTo (jQuery '#stage')
    clone.css
      right: 0
      top: 0
      position: 'absolute'
      zoom: 0.25
{EventEmitter} = require 'events'

module.exports = class Layout extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @dom = jQuery """<div>"""
    @dom.css background: 'red'
    @dom.draggable()
    
    zoom = 1
    @dom.on 'mousewheel', (event) =>
      {originalEvent} = event
      
      val = originalEvent.wheelDelta
      if 0 < val
        zoom *= 1.1
      else if val < 0
        zoom *= 0.9
      
      event.preventDefault()
      
      @dom.css zoom: zoom
    
    for key, slot of @template.slots.objects
      
      dom = jQuery """<div>"""
      dom.css
        position: 'absolute'
        background: 'black'
        overflow: 'hidden'
        border: '5px solid black'
        'box-shadow': 'inset 0px 0px 0px 5px white'
        'background-image': 'url(/css/images/icons/plus-transparent.png)'
        'background-size': '50%'
        'background-repeat': 'no-repeat'
        'background-position': 'center'
      
      dom.css left: slot.x, top: slot.y, width: slot.width, height: slot.height
      dom.appendTo @dom
      
      dom.resizable()
      dom.draggable()
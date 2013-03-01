{EventEmitter} = require 'events'

SlotView = require './slot'

module.exports = class LayoutView extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @layout = args.layout
    
    @dom = dom = jQuery """<div>"""
    
    dom.css
      width: @width
      height: @height
      background: "url(/css/images/masks/#{@layout.template.mask})"
      'background-size': 'cover'
    
    for key, slot of @layout.template.slots
      
      view = new SlotView slot: slot, layoutView: this, layout: @layout, editor: @editor
      
      @dom.append view.dom
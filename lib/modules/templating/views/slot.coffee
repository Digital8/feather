{EventEmitter} = require 'events'

module.exports = class SlotView extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @dom = dom = jQuery """<div>"""
    # dom.attr 'data-key', @slot.id
    dom.css
      position: 'absolute'
      background: 'black'
      overflow: 'hidden'
      # border: '5px solid black'
      # 'box-shadow': 'inset 0px 0px 0px 5px white'
      'background-image': 'url(/css/images/icons/plus-transparent-pad.png)'
      'background-size': 'contain'
      'background-repeat': 'no-repeat'
      'background-position': 'center'
    
    dom.css
      left: @slot.x * @layoutView.width
      top: @slot.y * @layoutView.height
      width: @slot.width * @layoutView.width
      height: @slot.height * @layoutView.height
    
    # dom.appendTo @slot.layout.view.dom
    
    # dom.resizable()
    # dom.draggable()
    
    dom.click (event) =>
      
      @editor.editSlot slot: @slot, layoutView: @layoutView, layout: @layout
    
    # dom.click =>
    #   @slot.dom.fadeOut()
      
    #   @slot.editor.surface.setSize @slot.view.width(), @slot.view.height()
      
    #   key = @slot.id
      
    #   @slot.layout.clone.find("[data-key=#{key}]").css
    #     'background-color': 'green'
    #     'background-image': 'url(/css/images/icons/plus-transparent-pad.png)'
      
    #   @slot.layout.clone.show()
      
    #   @slot.editor.surface.wrapper.fadeIn()
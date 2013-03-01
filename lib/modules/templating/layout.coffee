{EventEmitter} = require 'events'

Slot = require './slot'

LayoutView = require './views/layout'

module.exports = class Layout extends EventEmitter
  
  constructor: (args = {}) ->
    
    super
    
    @[key] = value for key, value of args
    
    @scale = (jQuery '#stage').height() * 0.9
    
    @width = @scale * @template.aspect
    @height = @scale
    
    @view = new LayoutView
      layout: this
      width: @width
      height: @height
    
    @view.dom.appendTo (jQuery '#stage')
    @view.dom.hide().fadeIn()
    
    delta =
      width: @view.dom.width() - (jQuery '#stage').width()
      height: @view.dom.height() - (jQuery '#stage').height()
    
    @view.dom.css
      position: 'absolute'
      left: -(delta.width / 2)
      top: -(delta.height / 2)
    
    @map = new LayoutView
      layout: this
      width: 175 * @template.aspect
      height: 175
    
    @map.dom.appendTo (jQuery '#map')
    
    # for _slot in @template.data
      
    #   slot = new Slot
    #     id: uuid()
    #     x: _slot.x
    #     y: _slot.y
    #     width: _slot.width
    #     height: _slot.height
    #     dom: @dom
    #     editor: @editor
    #     template: @template
    #     layout: this
    
    # @clone = @dom.clone()
    # @clone.appendTo (jQuery '#stage')
    # @clone.css
    #   right: 0
    #   top: 0
    #   position: 'absolute'
    #   zoom: 0.25
    # @clone.hide()
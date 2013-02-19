module.exports = class SlotView
  
  constructor: (args = {}) ->
    
    @slot = args.slot
    
    @dom = dom = jQuery """<div>"""
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
      left: @slot.x * @slot.template.width
      top: @slot.y * @slot.template.height
      width: @slot.width * @slot.template.width
      height: @slot.height * @slot.template.height
    
    dom.appendTo @slot.dom
    
    dom.resizable()
    dom.draggable()
    
    dom.click =>
      @slot.dom.fadeOut()
      
      @slot.editor.surface.setSize @slot.view.width(), @slot.view.height()
    
    return dom
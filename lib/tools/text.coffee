Tool = require '../tool'

module.exports = class Text extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    (jQuery "#text-value").keyup (event) =>
      @setText (jQuery event.target).val()
      return
    
    (jQuery '#font-value').change (event) =>
      val = (jQuery '#font-value').val()
      @text.css 'font-family': val
    
    (jQuery '#color').change =>
      val = (jQuery '#color').val()
      @text.css color: val
  
  setText: (text) ->
    @text.text text
    
    @emit 'setText', text
  
  activate: ->
    
    super
    
    if @text?
      
      @text.fadeIn()
    
    else
      
      @text = jQuery """<span>"""
      
      @text.css
        position: 'absolute'
        color: '#BADA55'
        'font-size': '32px'
        'text-align': 'center'
        # 'line-height': "#{@editor.ui.stage.height()}px"
        # width: @editor.ui.stage.width()
        left: 0
        top: 0
        zIndex: 1000000
        display: 'none'
      
      @text.draggable()
      
      @text.html 'Wall Creations'
      
      @editor.surface.element.append @text
      
      @text.css
        left: (@editor.surface.data.width / 2) - (@text.width() / 2)
        top: (@editor.surface.data.height / 2) - (@text.height() / 2)
      
      @text.fadeIn()
  
  deactivate: ->
    
    @text?.fadeOut()
Tool = require '../tool'

module.exports = class Text extends Tool
  
  constructor: (args = {}) ->
    
    super
    
    (jQuery "#text-value").keyup (event) =>
      @setText (jQuery event.target).val()
      return
    
    console.log 'made text tool'
  
  setText: (text) ->
    @text.text text
    
    @emit 'setText', text
  
  activate: ->
    
    console.log 'activating text'
    
    @text = jQuery """<span>"""
    
    @text.css
      position: 'absolute'
      color: 'black'
      'font-size': '32px'
      'text-align': 'center'
      'line-height': "#{@editor.ui.stage.height()}px"
      width: @editor.ui.stage.width()
      left: 0
      top: 0
      zIndex: 1000000
    
    @text.html 'test'
    
    (jQuery '#stage').append @text
  
  deactivate: ->
    
    console.log 'deactivating text'
    
    @text?.remove()
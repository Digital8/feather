module.exports = (editor) ->
  
  # constructor: (args = {}) ->
    
  #   super
    
  #   (jQuery "#text-value").keyup (event) =>
  #     @setText (jQuery event.target).val()
  #     return
    
  #   (jQuery '#font-value').change (event) =>
  #     val = (jQuery '#font-value').val()
  #     @dom.css 'font-family': val
    
  #   (jQuery '#color').change =>
  #     val = (jQuery '#color').val()
  #     @dom.css color: val
  
  # style: (element) ->
  #   element.css
  #     color: '#BADA55'
  #     'font-size': '32px'
  #     'text-align': 'center'
  
  # measureText: (text) ->
  #   sensor = jQuery """<span>"""
  #   @style sensor
  #   sensor.text text
  #   sensor.appendTo document.body
    
  #   result =
  #     width: sensor.width()
  #     height: sensor.height()
    
  #   sensor.remove()
    
  #   return result
  
  # setText: (text) ->
  #   @text.text text
    
  #   @dom.css (@measureText text)
    
  #   @emit 'setText', text
  
  # activate: ->
    
  #   super
    
  #   if @dom?
      
  #     @dom.fadeIn()
    
  #   else
      
  #     @dom = jQuery """<div>"""
      
  #     @dom.css
  #       position: 'absolute'
  #       width: '100%'
  #       height: '100%'
  #       left: 0
  #       top: 0
  #       zIndex: 1000000
  #       display: 'none'
      
  #     @text = jQuery """<div>"""
  #     @text.css
  #       position: 'absolute'
  #       left: 0
  #       top: 0
  #       width: '100%'
  #       height: '100%'
  #     @style @text
  #     @text.appendTo @dom
      
  #     @dom.draggable()
      
  #     @setText 'Wall Creations'
      
  #     surface = @editor.projects.active.surface
      
  #     surface.element.append @dom
      
  #     @dom.css
  #       left: (surface.data.width / 2) - (@dom.width() / 2)
  #       top: (surface.data.height / 2) - (@dom.height() / 2)
      
  #     @dom.resizable
  #       handles: 'all'
  #       aspectRatio: on
  #       resize: =>
  #         height = @text.height()
  #         @text.css 'font-size': height * 0.5
      
  #     @dom.find('.ui-resizable-handle').addClass 'ui-handle'
      
  #     @dom.fadeIn()
  
  # deactivate: ->
    
  #   @dom?.fadeOut()
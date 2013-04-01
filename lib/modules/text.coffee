module.exports = (editor) ->
  
  dispatch = (key, value) ->
    
    profile = editor.profiles.active
    return unless profile?
    
    project = profile.projects.active
    return unless project?
    
    layout = project.layouts.active
    return unless layout?
    
    slot = layout.slots.active
    return unless slot?
    
    text = slot.texts.active
    return unless text?
    
    text[key] = value
    text.emit key, value
  
  (jQuery "#text-value").keyup (event) =>
    dispatch 'value', (jQuery event.target).val()
    return
  
  (jQuery '#font-value').change (event) =>
    dispatch 'font', (jQuery '#font-value').val()
    return
  
  (jQuery '#color').change =>
    dispatch 'color', (jQuery '#color').val()
    return
  
  editor.kit.on 'activate', ({key}) ->
    return unless key is 'text'
    
    profile = editor.profiles.active
    project = profile.projects.active
    layout = project.layouts.active
    slot = layout.slots.active
    
    return unless slot?
    
    text = slot.texts.new
      width: 1
      height: 0.25
      top: 0.5
      left: 0
      value: 'WallCreations'
    slot.texts.activate text
  
  # constructor: (args = {}) ->
    
  #   super
    
  #   
  
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
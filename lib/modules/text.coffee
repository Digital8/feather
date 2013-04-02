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
  
  editor.ui.on 'text', (text) ->
    (jQuery "#text-value").val text.value
    (jQuery "#font-value").val text.font
    (jQuery "#font-value").change()
    # (jQuery "#color").setColor text.color
    debugger
    jQuery.farbtastic('#color').setColor text.color
  
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
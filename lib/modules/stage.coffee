module.exports = (editor) ->
  
  dom = editor.ui.stage = jQuery '#stage'
  
  # FFS
  dom.css height: '100%'
  
  stage = editor.stage =
    width: dom.width()
    height: dom.height()
  stage.aspect = stage.width / stage.height
  
  editor.ui.stage.mousedown (event) ->
    $target = jQuery event.target
    id = $target.attr 'id'
    
    # return unless id in ['wrapper', 'stage', 'surface']
    
    event.stopPropagation()
    event.preventDefault()
    
    # editor.deselect()
    
    editor.ui.emit 'deselect', event
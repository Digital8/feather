module.exports = (editor) ->
  
  editor.cancel = ->
    
    editor.kit.cancel (tool) ->
      editor.emit 'cancel', tool
  
  # ui
  editor.on 'ui', (key) ->
    return unless key is 'cancel'
    
    editor.cancel()
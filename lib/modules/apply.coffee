module.exports = (editor) ->
  
  editor.apply = ->
    editor.kit.apply (tool) ->
      editor.emit 'apply', tool
  
  # ui
  editor.on 'ui', (key) ->
    return unless key is 'apply'
    
    editor.apply()
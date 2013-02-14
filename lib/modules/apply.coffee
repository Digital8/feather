module.exports = (editor) ->
  
  apply = ->
    
    if editor.kit.active?
      
      editor.kit.active.apply? null
      
      editor.emit 'apply', editor.kit.active
  
  # ui
  editor.on 'ui', (key) ->
    
    if key is 'apply'
      
      apply()
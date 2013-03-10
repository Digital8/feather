module.exports = (editor) ->
  
  editor.apply = ->
    
    editor.kit.apply (tool) ->
      
      if tool?
        
        editor.emit 'apply', tool
  
  # ui
  editor.on 'ui', (key) ->
    
    return unless key is 'apply'
    
    editor.apply()
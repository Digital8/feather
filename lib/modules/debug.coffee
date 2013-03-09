module.exports = (editor) ->
  
  editor.debug = ->
  
  if editor.config.search.debug?
    
    editor.debug = ->
      console?.log arguments...
    
    editor.on 'uiready', =>
    
      editor.config.debug editor
    
    editor.on 'module', (key) ->
      
      editor.debug 'module', key
module.exports = (editor) ->
  
  editor.ui = {}
  
  editor.on 'ready', =>
    
    editor.config.ui editor
    
    editor.emit 'uiready'
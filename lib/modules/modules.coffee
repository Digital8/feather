module.exports = (editor) ->
  
  for key, _module of editor.config.modules
    
    editor.modules[key] = _module editor
    
    # editor.emit 'module', key
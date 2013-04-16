module.exports = (editor, args = {}) ->
  
  for key, _module of editor.config.modules
    
    editor.modules[key] = _module editor, args
    
    # editor.emit 'module', key
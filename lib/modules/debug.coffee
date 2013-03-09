module.exports = (editor) ->
  
  editor.debug = ->
  
  if editor.config.search.debug?
    
    editor.debug = ->
      console?.log arguments...
    
    editor.on 'uiready', =>
    
      editor.config.debug editor
    
    editor.on 'module', (module) ->
      
      groupMethod = if module.context.journal.length
        'group'
      else
        'groupCollapsed'
      
      console?[groupMethod]? "#{module.key} [#{module.context.journal.length}]"
      for entry in module.context.journal
        console.log entry...
      console?.groupEnd()
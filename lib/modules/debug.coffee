module.exports = (editor) ->
  
  editor.debug = ->
  
  if editor.config.search.debug?
    
    editor.debug = ->
      console?.log arguments...
    
    editor.on 'uiready', =>
    
      editor.config.debug editor
    
    editor.on 'module', (module) ->
      
      groupMethod = if module.context.console.journal.length
        'group'
      else
        'groupCollapsed'
      
      console?[groupMethod]? "#{module.key} [#{module.context.console.journal.length}]"
      for entry in module.context.console.journal
        console.log entry...
      console?.groupEnd()
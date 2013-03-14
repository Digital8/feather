module.exports = (editor) ->
  
  editor.save = ->
    
    editor.projects.active?.save()
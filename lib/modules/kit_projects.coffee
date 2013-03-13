module.exports = (editor) ->
  
  editor.projects.on 'deactivate', ->
      
      editor.kit.deactivate()
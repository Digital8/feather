Project = require '../project'

Library = require '../core/library'

module.exports = (editor) ->
  
  editor.projects = new Library type: Project
  
  editor.projects.activate = (project) ->
    
    active = editor.projects.active
    
    active?.deactivate? null
    
    active = editor.projects.active = project
    
    active?.activate? null
    
    @emit 'activate', project
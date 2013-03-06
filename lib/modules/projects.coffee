Project = require '../project'

Library = require '../core/library'

module.exports = (editor) ->
  
  editor.projects = new Library type: Project
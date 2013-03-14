Library = require '../core/library'

Behaviour = Activation: require '../core/behaviours/activation'

Project = require '../project'

module.exports = (editor) ->
  
  editor.projects = new Library type: Project
  Behaviour.Activation editor.projects
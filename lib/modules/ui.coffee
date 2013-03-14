{EventEmitter} = require 'events'

module.exports = (editor) ->
  
  editor.ui = new EventEmitter
  
  editor.on 'ready', =>
    
    editor.config.ui editor
    
    editor.emit 'uiready'
{EventEmitter} = require 'events'

module.exports = class Move extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->
    

Move.augment = (editor) ->
  
  editor.on 'graphic', (graphic) =>
    
    graphic.dom.draggable()
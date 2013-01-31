{EventEmitter} = require 'events'

module.exports = class Move extends EventEmitter
  
  constructor: ->
    
    super
  
  augment: (node) ->
    
    node.dom.parent('.ui-wrapper').draggable()

Move.augment = (editor) ->
  
  console.log 'augmenting editor with Move'
module.exports = (editor) ->
  
  editor.stage = stage = {}
  stage.dom = jQuery '#stage'
  stage.dom.css width: '100%', height: '100%'
  stage.width = stage.dom.width()
  stage.height = stage.dom.height()
  stage.position = stage.dom.position()
  stage.left = stage.position.left
  stage.top = stage.position.top
  
  stage.dom.mousedown (event) ->
    event.stopPropagation()
    event.preventDefault()
    editor.deselect()
  
  editor.on 'graphic', ->
    Feather.quality()
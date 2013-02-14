module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) =>
    
    graphic.delete =
      dom: jQuery """<div>"""
    
    graphic.delete.dom.css
      display: 'none'
      width: 20
      height: 20
      top: -10
      right: -10
      position: 'absolute'
      'line-height': 20
      'font-size': 20
    graphic.delete.dom.appendTo graphic.dom
    graphic.delete.dom.addClass 'ui-handle-delete'
    
    graphic.delete.dom.mousedown (event) ->
      graphic.remove()
    
    graphic.delete.hide = ->
      graphic.delete.dom.fadeOut()
    
    graphic.delete.show = ->
      graphic.delete.dom.fadeIn()
    
    graphic.on 'select', ->
      graphic.delete.show()
    
    graphic.on 'deselect', ->
      graphic.delete.hide()
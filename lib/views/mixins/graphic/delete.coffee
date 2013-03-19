module.exports = (graphicController) ->
  
  {graphic, view} = graphicController
  
  dom = jQuery '<div>'
  dom.appendTo view.dom
  dom.css
    # display: 'none'
    width: 20
    height: 20
    top: -10
    right: -10
    position: 'absolute'
    'line-height': 20
    'font-size': 20
  dom.addClass 'ui-handle-delete'
  
  dom.click (event) ->
    event.preventDefault()
    graphic.slot.graphics.remove graphic
    view.dom.remove()
  
  # graphic.delete.dom.mousedown (event) ->
  #   graphic.delete()
  
  # graphic.delete.hide = ->
  #   graphic.delete.dom.fadeOut()
  
  # graphic.delete.show = ->
  #   graphic.delete.dom.fadeIn()
  
  # graphic.on 'select', ->
  #   graphic.delete.show()
  
  # graphic.on 'deselect', ->
  #   graphic.delete.hide()
  
  # graphic.on 'delete', ->
  #   graphic.dom.fadeOut()
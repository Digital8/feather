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
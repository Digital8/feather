module.exports = (editor) ->
  
  editor.surface = surface =
    width: 750
    height: 500
    dom: (jQuery '#stage')
    editor: editor
  
  surface.aspect = surface.width / surface.height
  
  surface.wrapper = jQuery """<div>"""
  surface.wrapper.attr 'id', 'wrapper'
  surface.wrapper.css
    position: 'absolute'
    left: 0
    top: 0
    width: '100%'
    height: '100%'
  surface.dom.append surface.wrapper

  surface.elementsElement = jQuery """<div>"""
  surface.elementsElement.css
    position: 'absolute'
    left: 0
    top: 0
    width: '100%'
    height: '100%'
    opacity: 0.2
    '-webkit-pointer-events': 'none'
    'pointer-events': 'none'
    zIndex: 1000000000000
  surface.wrapper.append surface.elementsElement
  
  surface.element = jQuery """<div>"""
  surface.element.attr 'id', 'surface'
  surface.element.css
    position: 'absolute'
    left: 0
    top: 0
    width: '100%'
    height: '100%'
    border: '3px dashed'
    'border-color': 'rgb(180, 235, 250)'
  surface.element.data 'crop', true
  surface.wrapper.append surface.element
  
  spawn = (key) =>
    element = jQuery """<div>"""
    element.css
      position: 'absolute'
      background: 'black'
    surface.elementsElement.append element
    
    surface.elements ?= {}
    surface.elements[key] = element
  
  for key in ['top', 'left', 'right', 'bottom']
    spawn key

  surface.update = (x, y) ->
    
    baseMargin = 20
    
    margin = {x: null, y: null}
    
    surface.aspect = surface.width / surface.height
    
    surface.dom.css height: '100%'
    
    stage =
      width: surface.dom.width()
      height: surface.dom.height()
    stage.aspect = stage.width / stage.height
    
    if surface.aspect > stage.aspect
      margin.x = Math.floor baseMargin * stage.aspect
      scale = surface.width / (stage.width - 2 * margin.x)
      newHeight = surface.height / scale
      margin.y = Math.floor (stage.height - newHeight) / 2
    else
      margin.y = baseMargin
      scale = surface.height / (stage.height - 2 * margin.y)
      newWidth = surface.width / scale
      margin.x = Math.floor (stage.width - newWidth) / 2
    
    surface.data =
      top: margin.y
      left: margin.x
      width: stage.width - (2 * margin.x)
      height: stage.height - (2 * margin.y)
    
    surface.margin =
      x: margin.x
      y: margin.y
    
    surface.push()
  
  surface.push = ->
    surface.elements.top.css height: surface.margin.y, top: 0, width: '100%'
    surface.elements.bottom.css height: surface.margin.y, bottom: 0, width: '100%'
    surface.elements.left.css width: surface.margin.x, left: 0, height: '100%'
    surface.elements.right.css width: surface.margin.x, right: 0, height: '100%'
    
    surface.element.css surface.data
  
  surface.update()
module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    graphic.zoom = (factor) =>
      
      {dom} = graphic
      
      width = dom.width()
      height = dom.height()
      
      width *= factor
      height *= factor
      
      center = [
        dom.position().left + (dom.width() / 2)
        dom.position().top + (dom.height() / 2)
      ]
      
      dom.css
        width: width
        height: height
      
      dom.css
        left: center[0] - (width / 2)
        top: center[1] - (height / 2)
      
      graphic.emit 'zoom'
  
  zoom = (factor) ->
    editor.selected?.zoom factor
  
  (jQuery '#zoom-out').click (event) =>
    event.preventDefault()
    zoom 0.9
  
  (jQuery '#zoom-in').click =>
    event.preventDefault()
    zoom 1.1
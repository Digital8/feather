module.exports =
  
  none: (element) ->
    
    (jQuery element).bind 'click mouseover mousedown mouseout mousemove mouseup mousein', (event) ->
      
      @style.display = 'none'
      
      x = event.pageX
      y = event.pageY
      
      under = document.elementFromPoint x, y
      
      @style.display = ''
      
      event.stopPropagation()
      event.preventDefault()
      
      (jQuery under).trigger event.type
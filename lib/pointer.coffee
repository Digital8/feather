module.exports =
  
  none: (element) ->
    
    $element = jQuery element
    
    if Modernizr.pointerevents
      
      $element.css
        '-webkit-pointer-events': 'none'
        'pointer-events': 'none'
    
    unless Modernizr.pointerevents
      
      $element.bind 'click mouseover mousedown mouseout mousemove mouseup mousein', (event) ->
        
        @style.display = 'none'
        
        x = event.pageX
        y = event.pageY
        
        under = document.elementFromPoint x, y
        
        @style.display = ''
        
        event.stopPropagation()
        event.preventDefault()
        
        (jQuery under).trigger event
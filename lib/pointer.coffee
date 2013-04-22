module.exports =
  
  none: (element) ->
    
    $element = jQuery element
    
    # console.log 'Modernizr.pointerevents', Modernizr.pointerevents
    
    # if Modernizr.pointerevents
      
    # console.log 'native pointerevents'
      
    $element.css
      '-webkit-pointer-events': 'none'
      'pointer-events': 'none'
    
    # unless Modernizr.pointerevents
      
    #   console.log 'shimming pointerevents'
      
    #   $element.bind 'click mouseover mousedown mouseout mousemove mouseup mousein', (event) ->
        
    #     @style.display = 'none'
        
    #     x = event.pageX
    #     y = event.pageY
        
    #     under = document.elementFromPoint x, y
        
    #     @style.display = ''
        
    #     event.stopPropagation()
    #     event.preventDefault()
        
    #     (jQuery under).trigger event.type
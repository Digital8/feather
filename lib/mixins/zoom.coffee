  
  # zoom: (direction) ->
    
  #   scale = {
  #     in: 1.1
  #     out: 0.9
  #   }[direction]
    
  #   return unless @selectedImage?
    
  #   attrs = @selectedImage.image.attrs
    
  #   original =
  #     width: attrs.width
  #     height: attrs.height
    
  #   attrs.width = attrs.width * scale
  #   attrs.height = attrs.height * scale
    
  #   delta =
  #     x: original.width - attrs.width
  #     y: original.height - attrs.height
    
  #   attrs.x += delta.x / 2
  #   attrs.y += delta.y / 2
    
  #   @selectedImage.width = attrs.width
  #   @selectedImage.height = attrs.height
    
  #   console.log 'zoomed'
    
  #   @selectedImage.update()
    
  #   @emit 'zoom'
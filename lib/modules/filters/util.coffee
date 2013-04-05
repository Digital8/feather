module.exports =
  
  # imageDataToCanvas: (imageData) ->
  #   canvas = document.createElement 'canvas'
  #   canvas.width = imageData.width
  #   canvas.height = imageData.height
  #   (canvas.getContext '2d').putImageData imageData, 0, 0
  #   return canvas
  
  canvas: (width, height) ->
    canvas = document.createElement 'canvas'
    canvas.width = width
    canvas.height = height
    return canvas
  
  scaleImageToCanvas: (image, scale = 0.1) ->
    canvas = document.createElement 'canvas'
    canvas.width = image.width * scale
    canvas.height = image.height * scale
    (canvas.getContext '2d').drawImage image, 0, 0, canvas.width, canvas.height
    return canvas
  
  imageToCanvas: (image) ->
    canvas = document.createElement 'canvas'
    canvas.width = image.width
    canvas.height = image.height
    (canvas.getContext '2d').drawImage image, 0, 0, image.width, image.height
    return canvas
  
  createImageData: (ctx, width, height) ->
    if ctx.createImageData?
      ctx.createImageData width, height
    else
      ctx.getImageData 0, 0, width, height
module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    {image} = graphic
    
    surface = editor.surface.data
    surface.aspect = surface.width / surface.height
    
    image.aspect = image.width / image.height
    
    if image.aspect < surface.aspect
      scale = surface.width / image.width
    if image.aspect > surface.aspect
      scale = surface.height / image.height
    
    graphic.scale = scale
    
    width = image.width * scale
    height = image.height * scale
    
    graphic.width = width
    graphic.height = height
    
    image.width = width
    image.height = height
    
    graphic.dom.css
      width: width
      height: height
    
    src = editor.operations.scale.operate image: image, width: width, height: height
    # console.log src
    image.src = src
    
    editor.center graphic
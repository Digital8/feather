module.exports = (editor) ->
  
  editor.on 'graphic', (graphic) ->
    
    graphic.fit = ->
      
      {image, slot} = graphic
      
      if image.aspect < slot.aspect
        scale = slot.width / image.width
      if image.aspect > slot.aspect
        scale = slot.height / image.height
      
      # debugger
      
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
      
      console.log width, height
      
      # src = editor.operations.scale.operate image: image, width: width, height: height
      # image.src = src
      
      # editor.center graphic
module.exports = (editor) ->
  
  editor.cover = ({parent, child}) ->
    
    if child.aspect < parent.aspect
      scale = parent.width / child.width
    if child.aspect > parent.aspect
      scale = parent.height / child.height
    
    return {
      width: child.width * scale
      height: child.height * scale
    }
  
  # editor.contain2 = ({parent, child}) ->
    
  #   child =
  #     width: child.height
  #     height: child.width
    
  #   ratio = Math.max.apply Math, [
  #     parent.width / child.width
  #     parent.height / child.height
  #   ]
    
  #   size =
  #     width: child.width * ratio
  #     height: child.height * ratio
    
  #   aspect = child.width / child.height
    
  #   return {
  #     width: size.height * aspect
  #     height: size.height
  #   }
  
  editor.contain = ({parent, child}) ->
    
    ratio = Math.min.apply Math, [
      parent.width / child.width
      parent.height / child.height
    ]
    
    return {
      width: child.width * ratio
      height: child.height * ratio
    }
    
    # minMargin = 20
    
    # margin = {x: 0, y: 0}
    
    # if aspect > parent.aspect
    #   margin.x = Math.floor minMargin * parent.aspect
    #   scale = width / (parent.width - 2 * margin.x)
    #   newHeight = height / scale
    #   margin.y = Math.floor (parent.height - newHeight) / 2
    # else
    #   margin.y = minMargin
    #   scale = height / (parent.height - 2 * margin.y)
    #   newWidth = width / scale
    #   margin.x = Math.floor (parent.width - newWidth) / 2
    
    # data =
    #   top: margin.y
    #   left: margin.x
    #   width: parent.width - (2 * margin.x)
    #   height: parent.height - (2 * margin.y)
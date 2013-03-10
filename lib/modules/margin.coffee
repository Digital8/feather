module.exports = (editor) ->
  
  editor.margin = ({parent, child, margin}) ->
    
    size =
      width: child.width
      height: child.height
    
    initial =
      x: parent.width - child.width
      y: parent.height - child.height
    
    # if initial.x < margin
    
    if initial.x < (margin.x * 2) then size.width -= margin.x * 2
    if initial.y < (margin.y * 2) then size.height -= margin.y * 2
    
    # debugger
    
    return size
    
    # return {
    #   x: Math.max initial.x, margin
    #   y: Math.max initial.y, margin
    # }
    
    # console.log initial.x, initial.y
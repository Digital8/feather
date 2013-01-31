module.exports = (editor) ->
  
  # apply on [enter]
  (jQuery document).keyup ({keyCode}) ->
    if keyCode is 13
      editor.emit 'apply:request'
  
  # cancel on [esc]
  (jQuery document).keyup ({keyCode}) ->
    if keyCode is 27
      editor.emit 'cancel:request'
  
  # bind [1][2][3][4][5][6][7][8][9][0] to tools
  (jQuery document).keydown (event) ->
    
    if 48 <= event.which <= 58
      
      key = event.which - 49
      
      if key is -1 then key = 9
      
      el = (jQuery '#toolbar a')[key]
      $el = jQuery el
      
      $el.click()
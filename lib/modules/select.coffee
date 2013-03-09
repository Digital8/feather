module.exports = (editor) ->
  
  editor.deselect = (graphic) ->
    selected = editor.selected
    
    if selected?
      delete editor.selected
      selected.emit 'deselect'
      editor.emit 'deselect', selected
  
  editor.select = (graphic) ->
    return unless graphic
    
    return if graphic is editor.selected
    
    if editor.selected?
      editor.deselect editor.selected
    
    editor.selected = graphic
    graphic.emit 'select'
    editor.emit 'select', graphic
  
  editor.on 'graphic', (graphic) ->
    
    # graphic.dom.css
    #   'webkit-transition': 'box-shadow 0.33s'
    
    editor.zIndex ?= 666
    graphic.bringToTop = ->
      graphic.dom.css 'z-index': editor.zIndex++
    
    graphic.on 'select', ->
      graphic.dom.css 'box-shadow': '0px 0px 0px 3px #8ac53f'
    
    graphic.on 'deselect', ->
      graphic.dom.css 'box-shadow': ''
    
    # graphic.dom.find('img').bind 'mousedown', ->
    #   editor.select graphic
    #   false
    
    graphic.dom.mousedown (event) ->
      editor.select graphic
      return
    
    graphic.on 'select', ->
      graphic.bringToTop()
  
  return
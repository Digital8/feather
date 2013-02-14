module.exports = (editor) ->
  
  editor.filters = {}
  
  editor.resetFilters = ->
    editor.filters =
      sepia: '0%'
      brightness: '0'
      saturate: '100%'
      'hue-rotate': '0deg'
      contrast: '100%'
      blur: '0px'
  
  editor.buildCSS = ->
    parts = ("#{key}(#{value})" for key, value of editor.filters)
    return parts.join ' '
  
  editor.pushFilters = ->
    editor.graphics.map (key, graphic) ->
      graphic.dom.find('img').css
        '-webkit-filter': editor.buildCSS()
  
  editor.pushFilters()
  
  editor.on 'graphic', (graphic) ->
    editor.pushFilters()
  
  editor.setFilter = (key, value) ->
    editor.filters[key] = value
    editor.pushFilters()
  
  editor.setFilters = (map) ->
    for key, value of map
      editor.filters[key] = value
    editor.pushFilters()
  
  editor.preset = null
  
  editor.setPreset = (preset) ->
    
    if editor.preset?
      old = editor.preset
      editor.preset = null
      editor.emit 'unpreset', old
    
    editor.resetFilters()
    map = preset.exec()
    editor.setFilters map
    
    editor.preset = preset
    
    editor.emit 'preset', preset
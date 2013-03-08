module.exports = (editor) ->
  
  supportsCanvas = !!window.HTMLCanvasElement && !nocanvas
  
  console.log 'supportscanvas', supportsCanvas
  
  editor.filters = {}
  
  editor.getFilters = ->
    filters = {}
    for key, filter of editor.filters
      filters[key] = filter
    return filters
  
  editor.resetFilters = ->
    # editor.filters =
    #   sepia: '0%'
    #   brightness: '0'
    #   saturate: '100%'
    #   'hue-rotate': '0deg'
    #   contrast: '100%'
    #   blur: '0px'
    
    editor.filters =
      sepia: 0
      brightness: 0
      saturate: 0
      'hue-rotate': 0
      contrast: 0
      blur: 0
  
  editor.resetFilters()
  
  editor.buildCSS = ->
    parts = ("#{key}(#{value})" for own key, value of editor.filters)
    return parts.join ' '
    
  editor.buildQueryString = ->
    parts = ("#{key}=#{value}" for own key, value of editor.filters)
    return parts.join '&'
  
  editor.pushFilters = ->
    editor.graphics.map (key, graphic) ->
      if supportsCanvas
        graphic.dom.find('img').css
          '-webkit-filter': editor.buildCSS()
      else
        graphic.dom.find('img').attr 'src', "http://#{window.location.hostname}:8080/uploads/17118395?#{editor.buildQueryString()}"
  
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
_ = require 'underscore'

module.exports = (editor, args, context) ->
  
  window.nocanvas = false
  if window.location.search.indexOf('nocanvas') != -1
    window.nocanvas = true
  
  supportsCanvas = !!window.HTMLCanvasElement && !nocanvas
  
  context.log 'HTMLCanvasElement', supportsCanvas
  
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
    if supportsCanvas
      editor.normalPushFilters()
    else
      editor.throttlePushFilters()
  
  editor.throttlePushFilters = _.throttle ->
    editor.graphics.map (key, graphic) ->
      id = graphic.dom.find('img').attr 'id'
      graphic.dom.find('img').attr 'src', "http://#{window.location.hostname}:8080/uploads/#{id}?#{editor.buildQueryString()}"
  , 1000
  
  editor.normalPushFilters = ->
    # editor.graphics.map (key, graphic) ->
    #   graphic.dom.find('img').css
    #     '-webkit-filter': editor.buildCSS()
  
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
module.exports = (editor, args) ->
  
  editor.presets = args.presets or {}
  
  $container = jQuery '#tool-filters .tool-container'
  
  $container.empty()
  
  _template = (key) ->
    return jQuery """
      <a href="#" id="filter-#{key}" class="icon"><img src="/css/images/icons/filter-#{key}.png" alt="#{key}">#{key}</a>
    """
  
  binds = {}
  
  for key, preset of editor.presets then do (key, preset) ->
    template = _template key
    template.appendTo $container
    template.click (event) ->
      editor.emit 'ui', 'preset', key, preset
    
    binds[key] =
      dom: template
    
    template.find('img').css '-webkit-transition': 'all 0.75s'
  
  editor.on 'ui', (channel, key, preset) ->
    if channel is 'preset'
      editor.setPreset key: key, exec: preset
  
  editor.on 'preset', (preset) ->
    
    binds[preset.key].dom.find('img').css border: '5px solid #8ac53f'
  
  editor.on 'unpreset', (preset) ->
    
    binds[preset.key].dom.find('img').css border: ''
  
  editor.kit.on 'activate', ({key}) ->
    return unless key is 'filter'
    $container.find('a img').css border: ''
module.exports =
  Editor: require './lib/editor'
  # debug: require './lib/debug'
  quality: require './lib/quality'
  Tools: require './lib/tools'
  
  bind: (editor, bindings) ->
    
    bound = {}
    
    editor.binds = binds = {}
    
    for selector, binding of bindings
      
      bound[selector] ?=
        selector: selector
        binding: binding
        $ul: jQuery selector
        events: binding.events
      
      $toolbar = jQuery selector
      
      $ul = jQuery """<ul>"""
      $ul.appendTo $toolbar
      
      $ul.empty()
      
      for key, value of binding.list then do (key, value) =>
        value.key ?= key
        template = (do binding.view) value
        $el = jQuery template
        $el.appendTo $ul
        
        $el.click (event) ->
          event.preventDefault()
          editor.emit 'ui', binding.key, key, event
        
        $a = $el.find 'a'
        
        $el.find('.tooltip').css 'text-transform': 'capitalize'
        
        binds[key] =
          li: $el
          a: $a
          args: value
        
        (jQuery "input[name=#{value.ui or value.key}]").change (event) ->
          editor.emit 'ui', "slider", (value.key), event.target.value
      
      editor.kit.on 'activate', ({key}) ->
        binds[key].a.addClass 'active'
      editor.kit.on 'deactivate', ({key}) ->
        binds[key].a.removeClass 'active'
      
      editor.kit.on 'activate', ({key}) ->
        key = binds[key].args.ui or key
        (jQuery "#tool-#{key}").fadeIn()
      editor.kit.on 'deactivate', ({key}) ->
        key = binds[key].args.ui or key
        (jQuery "#tool-#{key}").fadeOut()
      
      for key, value of binding.events then do (key, value) =>
        
        editor.on key, ->
          
          value key
module.exports =
  Editor: require './lib/editor'
  # debug: require './lib/debug'
  quality: require './lib/quality'
  Tools: require './lib/tools'
  
  bind: (app, bindings) ->
    
    bound = {}
    
    binds = {}
    
    for selector, binding of bindings
      
      bound[selector] ?=
        selector: selector
        binding: binding
        $ul: jQuery selector
        events: binding.events
      
      $ul = jQuery selector
      
      $ul.empty()
      
      for key, value of binding.list then do (key, value) =>
        value.key ?= key
        template = (do binding.view) value
        $el = jQuery template
        $el.appendTo $ul
        
        $el.click (event) ->
          event.preventDefault()
          app.emit 'ui', binding.key, key, event
        
        $a = $el.find 'a'
        
        $el.find('.tooltip').css 'text-transform': 'capitalize'
        
        binds[key] =
          li: $el
          a: $a
          args: value
        
        (jQuery "input[name=#{value.ui or value.key}]").change (event) ->
          app.emit 'ui', "slider", (value.key), event.target.value
      
      app.kit.on 'activate', ({key}) ->
        binds[key].a.addClass 'active'
      app.kit.on 'deactivate', ({key}) ->
        binds[key].a.removeClass 'active'
      
      app.kit.on 'activate', ({key}) ->
        key = binds[key].args.ui or key
        (jQuery "#tool-#{key}").fadeIn()
      app.kit.on 'deactivate', ({key}) ->
        key = binds[key].args.ui or key
        (jQuery "#tool-#{key}").fadeOut()
      
      for key, value of binding.events then do (key, value) =>
        
        app.on key, ->
          
          value key
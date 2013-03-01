module.exports = (editor) ->
  
  editor.mapTools = (key) ->
    (jQuery '#toolbar ul li').each (index) ->
      (jQuery this).delay(50 * index)[key] null
  
  editor.showTools = -> editor.mapTools 'fadeIn'
  editor.hideTools = -> editor.mapTools 'fadeOut'
  
  editor.showTemplate = () ->
    
    editor.surface.wrapper.fadeOut()
    
    (jQuery '#tool-picture-wall').fadeIn()
    
    editor.hideTools()
    
    (jQuery '#controls .canvas .bracket').fadeOut()
    (jQuery '#controls .canvas .sliders').fadeOut()
    
    (jQuery '#controls .map').fadeIn()
    
    (jQuery '#controls .map').hover (->
      (jQuery '#controls .map span').stop(true, true).fadeIn()
    ), (->
      (jQuery '#controls .map span').fadeOut()
    )
  
  editor.hideTemplate = () ->
    
    (jQuery '#tool-picture-wall').fadeOut()
    
    editor.surface.wrapper.fadeIn()
    
    editor.showTools()
    
    (jQuery '#controls .canvas .bracket').fadeIn()
    (jQuery '#controls .canvas .sliders').fadeIn()
    
    (jQuery '#controls .map').fadeOut()
  
  editor.hideLayouts = ->
    editor.layouts.map (key, layout) =>
      layout.view.dom.fadeOut()
  
  return {
    
    activate: ->
      editor.showTemplate()
      
      editor.templates.get('simple').spawn()
    
    deactivate: ->
      
      editor.hideTemplate()
      
      editor.hideLayouts()
  }
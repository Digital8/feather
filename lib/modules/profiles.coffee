module.exports = (editor) ->
  
  profiles =
    'Picture Wall': (require './templating/profile') editor
    'Wall Art':
      activate: -> (jQuery '#tool-wall-art').fadeIn()
      deactivate: -> (jQuery '#tool-wall-art').fadeOut()
  
  for key in ['Wall Mural', 'Occasional Banner']
    profiles[key] =
      key: key
      activate: ->
      deactivate: ->
  
  active =
    key: 'master'
    activate: ->
    deactivate: ->
  
  select = jQuery '#profile'
  
  select.change ->
    
    key = select.val()
    
    # if the profile is being switched...
    unless key is active.key
      
      active?.deactivate()
      
      active = profiles[key]
      
      active.activate()
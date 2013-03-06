Library = require '../core/library'

Profile = require '../profile'

module.exports = (editor, args) ->
  
  editor.profiles = new Library type: Profile, key: 'key'
  
  for key, prototype of args.profiles
    instance = new prototype editor: editor
    editor.profiles.add instance
  
  editor.profiles.active = null
  
  editor.profiles.activate = (key) ->
    # if the profile is being switched...
    
    active = editor.profiles.active
    
    unless key is active?.key
      
      active?.deactivate? null
      
      editor.profiles.active = active = editor.profiles.get key
      
      active.activate? null
      
    editor.profiles.emit 'activate'
  
  editor.profiles.deactivate = ->
    
    active = editor.profiles.active
    active?.deactivate? null
    editor.profiles.active = null
    
    editor.profiles.emit 'deactivate'
  
  # profiles =
  #   'Picture Wall': (require './templating/profile') editor
  #   'Wall Art':
  #     activate: -> (jQuery '#tool-wall-art').fadeIn()
  #     deactivate: -> (jQuery '#tool-wall-art').fadeOut()
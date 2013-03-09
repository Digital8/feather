Library = require '../core/library'

Profile = require '../profile'

module.exports = (editor, args) ->
  
  {config} = args
  
  editor.profiles = new Library type: Profile, key: 'key'
  
  for key, _profile of config.profiles
    _profile.entry? editor, args
  
  for key, _profile of config.profiles
    profile = new _profile.Profile editor: editor, projectPrototype: _profile.Project
    editor.profiles.add profile
  
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
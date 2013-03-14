Library = require '../core/library'

Behaviour = Activation: require '../core/behaviours/activation'

Profile = require '../profile'

module.exports = (editor, args) ->
  
  {config} = args
  
  editor.profiles = new Library type: Profile, key: 'key'
  Behaviour.Activation editor.profiles
  
  for key, _profile of config.profiles
    _profile.entry? editor, args
  
  for key, _profile of config.profiles
    
    profile = new _profile.Profile
      editor: editor
      projectPrototype: _profile.Project
    
    editor.profiles.add profile
module.exports =
  Library: require './lib/core/library'
  Editor: require './lib/editor'
  Profile: require './lib/profile'
  Project: require './lib/project'
  Mask: require './lib/mask'
  Tools: require './lib/tools'
  clamp: require './lib/clamp'
  Behaviour:
    Population: require './lib/core/behaviours/population'
  Controller:
    Graphic: require './lib/controllers/graphic'
  View:
    Graphic: require './lib/views/graphic'
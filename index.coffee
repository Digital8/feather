module.exports =
  Library: require './lib/core/library'
  Editor: require './lib/editor'
  Graphic: require './lib/graphic'
  Text: require './lib/text'
  Profile: require './lib/profile'
  Project: require './lib/project'
  Mask: require './lib/mask'
  Tools: require './lib/tools'
  clamp: require './lib/clamp'
  Behaviour:
    Population: require './lib/core/behaviours/population'
    Activation: require './lib/core/behaviours/activation'
  Controller:
    Graphic: require './lib/controllers/graphic'
    Text: require './lib/controllers/text'
  View:
    Graphic: require './lib/views/graphic'
    Text: require './lib/views/text'
  filters:
    process_image: require './lib/modules/filters/process_image'
  parse: require './lib/parse'
  pointer: require './lib/pointer'
  opacity: require './lib/opacity'
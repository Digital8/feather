module.exports =
  
  environment: require './environment'
  
  debug: require './debug'
  
  config: require './config'
  
  graphics: require './graphics'
  
  kit: require './kit'
  
  ui: require './ui'
  stage: require './stage' # deps: [ui]
  
  delete: require './delete'
  
  profiles: require './profiles'
  
  filters: require './filters'  # deps: [profiles]
  
  contain: require './contain'
  margin: require './margin'
  cover: require './cover'
  center: require './center'
  
  text: require './text'
  
  apply: require './apply'
  cancel: require './cancel'
  
  reset: require './reset'
  
  ready: require './ready'
  
  modules: require './modules'
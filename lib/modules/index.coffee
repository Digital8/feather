module.exports =
  
  environment: require './environment'
  
  debug: require './debug'
  
  config: require './config'
  
  # projects: require './projects'
  
  graphics: require './graphics'
  
  kit: require './kit'
  
  ui: require './ui'
  stage: require './stage' # deps: [ui]
  
  delete: require './delete'
  
  profiles: require './profiles'
  
  filters: require './filters'  # deps: [profiles]
  
  select: require './select'
  
  fit: require './fit'
  contain: require './contain'
  margin: require './margin'
  measure: require './measure'
  cover: require './cover'
  
  center: require './center'
  
  crop: require './crop'
  
  move: require './move'
  
  scale: require './scale'
  
  zoom: require './zoom'
  
  orientation: require './orientation'
  
  operations: require './operations'
  
  apply: require './apply'
  
  cancel: require './cancel'
  
  save: require './save'
  load: require './load'
  
  quality: require './quality'
  
  reset: require './reset'
  
  ready: require './ready'
  
  modules: require './modules'
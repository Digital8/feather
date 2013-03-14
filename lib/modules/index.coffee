module.exports =
  
  environment: require './environment'
  
  debug: require './debug'
  
  config: require './config'
  
  projects: require './projects'
  
  graphics: require './graphics'
  
  kit: require './kit'
  
  ui: require './ui'
  stage: require './stage' # deps: [ui]
  
  filters: require './filters'
  
  # surfaces: require './surfaces'
  
  delete: require './delete'
  
  presets: require './presets'
  
  # reader: require './reader'
  
  # layouts: require './layouts'
  
  profiles: require './profiles'
  
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
  
  # templating: require './templating'
  
  reset: require './reset'
  
  kit_projects: require './kit_projects'
  
  ready: require './ready'
  
  modules: require './modules'
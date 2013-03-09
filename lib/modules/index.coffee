module.exports =
  
  environment: require './environment'
  
  debug: require './debug'
  
  projects: require './projects'
  
  graphics: require './graphics'
  
  filters: require './filters'
  
  kit: require './kit'
  
  ui: require './ui'
  stage: require './stage' # deps: [ui]
  
  surfaces: require './surfaces'
  
  delete: require './delete'
  
  presets: require './presets'
  
  reader: require './reader'
  
  # layouts: require './layouts'
  
  profiles: require './profiles'
  
  select: require './select'
  
  fit: require './fit'
  
  center: require './center'
  
  crop: require './crop'
  
  move: require './move'
  
  scale: require './scale'
  
  zoom: require './zoom'
  
  orientation: require './orientation'
  
  operations: require './operations'
  
  apply: require './apply'
  
  cancel: require './cancel'
  
  export: require './export'
  load: require './load'
  
  quality: require './quality'
  
  # templating: require './templating'
  
  reset: require './reset'
  
  ready: require './ready'
  
  modules: require './modules'
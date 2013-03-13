module.exports = (input) ->
  
  if input in ['on', 'yes', 'true'] then return true
  if input in ['off', 'no', 'false'] then return false
  
  return
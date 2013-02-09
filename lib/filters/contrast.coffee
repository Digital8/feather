module.exports = (value) ->
  
  if value < 0
    value *= -0.75
    value = 100 - value
  else
    value *= 3.33
  
  return "#{value}%"
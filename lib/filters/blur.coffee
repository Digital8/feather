module.exports = (value) ->
  
  value /= 50
  value *= -1
  value *= 5
  value = Math.max 0, value
  
  return "#{value}px"
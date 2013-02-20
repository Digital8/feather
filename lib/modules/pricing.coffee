module.exports = (editor) ->
  
  editor.pricing = { price: null }
    
  editor.on 'resize', (width, height) ->

    editor.profile ?= 'wall_mural'
    product = editor.profile
    
    price = 0
    supply_rate = 80
    install_rate = 50
    sqm = width * height / 10000
    
    switch product
      when 'wall_mural'
        supply_rate = 80
        install_rate = 50
        
      when 'wall_art'
        supply_rate = 70
        install_rate = 40
      
      when 'occasional_banner'
        supply_rate = 40
        install_rate = 20
      
      when 'picture_wall'
        supply_rate = 120
        install_rate = 50
        
    if (width*height) < 0.5
      price = supply_rate * 1.1
    else
      price = sqm * supply_rate * 1.1
    
    editor.pricing.price = parseInt price
    jQuery("#price").html price.toString()
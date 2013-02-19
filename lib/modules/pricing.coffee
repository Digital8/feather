module.exports = (editor) ->
  
  editor.pricing = pricing = { price: null }
    
  editor.on 'resize', (width, height) ->
    ###
      wall_mural
      wall_art
      ocassional_banner
    ###
    editor.profile ?= 'wall_mural'
    product = editor.profile
    
    price = "POA"
    
    switch product
      when 'wall_mural'
        if height < 50 and width < 50
          price = 80
        else if height < 60 and width < 80
          price = 80
        else if height < 80 and width < 100
          price = 95
        else if height < 100 and width < 240
          price = 223
        else if height < 240 and width < 300
          price = 607
        else if height < 500 and width < 500
          price = 2031
        
      when 'wall_art'
        if height < 50 and width < 50
          price = 70
        else if height < 60 and width < 80
          price = 70
        else if height < 80 and width < 100
          price = 87
        else if height < 100 and width < 240
          price = 199
        else if height < 240 and width < 300
          price = 535
        else if height < 500 and width < 500
          price = 1781
      
      when 'occasional_banner'
        if height < 50 and width < 50
          price = 60
        else if height < 60 and width < 80
          price = 60
        else if height < 80 and width < 100
          price = 63
        else if height < 100 and width < 240
          price = 108
        else if height < 240 and width < 300
          price = 319
        else if height < 500 and width < 500
          price = 1031
      
      when 'picture_wall'
        if height < 50 and width < 50
          price = 100
        else if height < 60 and width < 80
          price = 100
        else if height < 80 and width < 100
          price = 127
        else if height < 100 and width < 240
          price = 250
        else if height < 240 and width < 300
          price = 895
        else if height < 500 and width < 500
          price = 3031
          
    jQuery("#price").html price.toString()
read_batch = function(files, format, channels, windows, parts, w , h, rot, flip, aug){
  
  
  batch = array(0, dim = c(length(windows), w, h, channels))
  
  for(i in 1:length(files)){
    
    file = files[i]
    im = readImage(as.character(file))
    
    if(aug){
    im = augment(im = im, rot =rot, flip = flip)
    }
    
  for(j in 1:length(windows)){
    window = windows[j]
  y=  floor( (window -1 )/parts) +1
  x = window - (y-1)*parts
    
    batch[j,,,] = im[ ((x-1)*w + 1)  :(x*w) , ((y-1)*h + 1)  :(y*h)  ,]
  }
  
  }
   
  return(batch)
}
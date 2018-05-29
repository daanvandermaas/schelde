library(rgdal)
library(raster)
library(gdalUtils)
library(rgeos)
library(tiff)



shape = readOGR( 'db/geomorfologie_shapes/2016/west')
shape$class = as.numeric(shape$OMS_GEOCOD)

images =  list.files('db/geomorfologie_tiffs/Mosaic_Westerchelde_2016', pattern = 'tif', full.names = TRUE)

for(i  in 27:length(images)){
  image = images[i]
  print(image)
  
  im = stack(image)
  
  sub_shape = crop(shape, im)
  
  if(!is.null(sub_shape)){
    r = raster::rasterize(x = sub_shape, y = im, field = sub_shape$class , background = 0 )
    
    name = strsplit(image, '/')[[1]][9]
    
    writeRaster(r,  paste0('db/labels/2016/west/', name) , overwrite = TRUE )
  }
  
}




path = '/home/daniel/R/schelde/db/geomorfologie_shapes/2016'


shape = readOGR( 'db/geomorfologie_shapes/2016/oost')
shape$class = as.numeric(shape$OMS_GEOCOD)

images = list.files('db/geomorfologie_tiffs/Mosaic_Oosterchelde_2016', pattern = 'tif', full.names = TRUE)

for(i  in 27:length(images)){
  image = images[i]
  print(image)
  
  im = stack(image)
  
  sub_shape = crop(shape, im)
  
  if(!is.null(sub_shape)){
    r = raster::rasterize(x = sub_shape, y = im, field = sub_shape$class , background = 0 )
    
    name = strsplit(image, '/')[[1]][9]
    
    writeRaster(r,  paste0('db/labels/2016/oost/', name) , overwrite = TRUE )
  }
  
}
library(rgdal)
library(raster)
library(gdalUtils)
library(rgeos)
library(tiff)


# 
# shape_1 = readOGR( 'db/geomorfologie_shapes/2016/oost')
# shape_2 =  readOGR( 'db/geomorfologie_shapes/2016/west')
# shape_1@data = data.frame('class_oms' = shape_1$OMS_GEOCOD, 'class_code' = shape_1$GEOCODE2 , stringsAsFactors = FALSE )
# shape_2@data = data.frame('class_oms' = shape_2$OMS_GEOCOD , 'class_code' = shape_2$GEOCODE2 , stringsAsFactors = FALSE )
# shape = rbind(shape_1, shape_2)
# shape$label =  as.numeric(shape$class_code)

#saveRDS(shape, 'db/shape_total.rds')

shape = readRDS('db/shape_total.rds')

images =  list.files('db/geomorfologie_tiffs/Mosaic_Westerchelde_2016', pattern = 'tif', full.names = TRUE)
for(i  in 27:length(images)){
  image = images[i]
  print(image)
  
  im = stack(image)
  
  sub_shape = crop(shape, im)
  
  if(!is.null(sub_shape)){
    r = raster::rasterize(x = sub_shape, y = im, field = sub_shape$class , background = 0 )
    
    name = strsplit(image, '/')[[1]][9]
    
    writeRaster(r,  paste0('db/geomorfologie_labels/west_2016/', name) , overwrite = TRUE )
  }
  
}




images = list.files('db/geomorfologie_tiffs/Mosaic_Oosterchelde_2016', pattern = 'tif', full.names = TRUE)

for(i  in 27:length(images)){
  image = images[i]
  print(image)
  
  im = stack(image)
  
  sub_shape = crop(shape, im)
  
  if(!is.null(sub_shape)){
    r = raster::rasterize(x = sub_shape, y = im, field = sub_shape$class , background = 0 )
    
    name = strsplit(image, '/')[[1]][9]
    
    writeRaster(r,  paste0('db/geomorfologie_labels/oost_2016/', name) , overwrite = TRUE )
  }
  
}
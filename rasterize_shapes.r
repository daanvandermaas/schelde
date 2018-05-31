# 
# shape_1 = readOGR( 'db/geomorfologie_shapes/2016/oost')
# shape_2 =  readOGR( 'db/geomorfologie_shapes/2016/west')
# shape_1@data = data.frame('class_oms' = shape_1$OMS_GEOCOD, 'class_code' = shape_1$GEOCODE2 , stringsAsFactors = FALSE )
# shape_2@data = data.frame('class_oms' = shape_2$OMS_GEOCOD , 'class_code' = shape_2$GEOCODE2 , stringsAsFactors = FALSE )
# shape = rbind(shape_1, shape_2)
# shape$label =  as.numeric(shape$class_code)

#saveRDS(shape, 'db/shape_total.rds')



library(parallel)
cl <- makeCluster(40)

clusterCall(cl, function(){
  library(rgdal)
  library(raster)
  library(rgeos)
  library(tiff)
})

images =  list.files('db/geomorfologie_tiffs/west_2016', pattern = 'tif', full.names = TRUE)
shape = readRDS('db/shape_total.rds')


clusterExport(cl, varlist = c("images", "shape"))







parLapply(cl, c(1:length(images)), function(i){
 image = images[i]
  print(image)
  
  im = stack(image)
  
  sub_shape = crop(shape, im)
  
  if(!is.null(sub_shape)){
    r = raster::rasterize(x = sub_shape, y = im, field = sub_shape$label , background = 0 )
    
    name = strsplit(image, '/')[[1]][4]
    
    writeRaster(r,  paste0('db/geomorfologie_labels/west_2016/', name) , overwrite = TRUE )
  }
  
})


images = list.files('db/geomorfologie_tiffs/oost_2016', pattern = 'tif', full.names = TRUE)
shape = readRDS('db/shape_total.rds')


clusterExport(cl, varlist = c("shape", "images"))


parLapply( cl, c(1:length(images)), function(i){
  
  

  
  
  image = images[i]
  print(image)
  
  im = stack(image)
  
  sub_shape = crop(shape, im)
  
  if(!is.null(sub_shape)){
    r = raster::rasterize(x = sub_shape, y = im, field = sub_shape$label , background = 0 )
    
    name = strsplit(image, '/')[[1]][4]
    
    writeRaster(r,  paste0('db/geomorfologie_labels/oost_2016/', name) , overwrite = TRUE )
  }
  
})






library(feather)
library(raster)


files = list.files('db/labels_parts')

n = round( 0.5* length(files))

for(i in 1:n){
  file = files[i]
  lab = read_feather(file.path('db/labels_parts', file))
 lab = as.matrix(lab)
 r = raster(lab)
 file = gsub(file, pattern = '.fe', replacement = '.tif')
 writeRaster(r, file.path('db/labels_patrick_1', file), overwrite = TRUE)
}


for(i in (n+1):length(files)){
  file= files[i]
  lab = read_feather(file.path('db/labels_parts', file))
  lab = as.matrix(lab)
  r = raster(lab)
  file = gsub(file, pattern = '.fe', replacement = '.tif')
  writeRaster(r, file.path('db/labels_patrick_2', file), overwrite = TRUE)
}
library(raster)
library(tiff)
library(EBImage)
library(feather)

labels =  setdiff(  list.files('db/labels/2016/oost', pattern = '.tif'), list.files('db/labels/2016/oost', pattern = 'xml')  )

files =  file.path('db', 'geomorfologie_tiffs', 'oost_2016', labels)
labels = file.path('db', 'labels', '2016', 'oost', labels)
  
  
w = 608
h = 608


for(i in 1:length(labels)){
  label = labels[i]
  file = files[i]
  
  r = readTIFF(label)
  im = readTIFF(file, convert = TRUE)
  
  
  
  parts_w = floor(dim(r)[1]/ w)
  parts_h = floor(dim(r)[2]/ h) 
  
  for(x in 1:parts_w){
    for(y in 1:parts_h){
      print(y)
      r_part = as.data.frame(r[ ((x-1)*w + 1)  :(x*w) , ((y-1)*h + 1)  :(y*h) ])
      im_part = Image(im[ ((x-1)*w + 1)  :(x*w) , ((y-1)*h + 1)  :(y*h), ], colormode = 'color')
      if(sum(r_part)>0){
        name = paste0(strsplit(label, '[./]')[[1]][5], '_', x, '_', y, '.fe')
        write_feather(r_part, file.path('db', 'labels_parts', name))
        
        name = paste0(strsplit(label, '[./]')[[1]][5], '_', x, '_', y, '.jpg')
        writeImage(im_part, file.path('db', 'images_parts', name))
      }
  }}
  
}





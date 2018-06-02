library(feather)
library(EBImage)
library(tiff)

w = 16000
h = 16000


##########
labels_oost =  setdiff(  list.files('db/geomorfologie_labels/oost_2016', pattern = '.tif'), list.files('db/geomorfologie_labels/oost_2016', pattern = 'xml')  )
files =  file.path('db', 'geomorfologie_tiffs', 'oost_2016', labels_oost)
labels_oost = file.path('db', 'geomorfologie_labels', 'oost_2016', labels_oost)

labels = labels_oost


for( i in  1:length(labels)){
  print(i/length(labels))
  
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
        name = paste0(strsplit(label, '[./]')[[1]][4], '_', x, '_', y, '.fe')
        write_feather(r_part, file.path('db', 'lab_very_large', paste0('oost_' , name) ))
        
        name = paste0(strsplit(label, '[./]')[[1]][4], '_', x, '_', y, '.jpg')
        writeImage(im_part, file.path('db', 'im_very_large', paste0('oost_' , name)))
      }
    }}
  
}









labels_west =  setdiff(  list.files('db/geomorfologie_labels/west_2016', pattern = '.tif'), list.files('db/geomorfologie_labels/west_2016', pattern = 'xml')  )
files =  file.path('db', 'geomorfologie_tiffs', 'west_2016', labels_west)
labels_west = file.path('db', 'geomorfologie_labels', 'west_2016', labels_west)


labels = labels_west


###################

for( i in  1:length(labels)){
print(i/length(labels))
  
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
        name = paste0(strsplit(label, '[./]')[[1]][4], '_', x, '_', y, '.fe')
        write_feather(r_part, file.path('db', 'lab_very_large',  paste0('west_' , name) ))
        
        name = paste0(strsplit(label, '[./]')[[1]][4], '_', x, '_', y, '.jpg')
        writeImage(im_part, file.path('db', 'im_very_large', paste0('west_' , name) ))
      }
  }}
  
}




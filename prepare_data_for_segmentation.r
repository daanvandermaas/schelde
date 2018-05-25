library(raster)
library(EBImage)


labels =  setdiff( intersect( list.files('db/clouds', pattern = 'csf'), list.files('db/clouds', pattern = '.dat') ), list.files('db/clouds', pattern = 'xml')  )

files = setdiff( setdiff(list.files('db/clouds' , pattern = '.dat'), labels), list.files('db/clouds', pattern = 'xml'))

w = 608
h = 608


for(label in labels){
  r = raster(file.path('db', 'clouds', label))
  r = as.array(r)
  r[!is.na(r)] = 0L
  r[is.na(r)] = 1L
  a = array(0, dim = c(dim(r)[1:2], 2))
  a[,,1] = r[,,1]
  a[,,2] = 1L- r[,,1]
  r= a
  rm(a)
  
  parts_w = floor(dim(r)[1]/ w)
  parts_h = floor(dim(r)[2]/ h) 
  
  
  for(x in 1:parts_w){
    for(y in 1:parts_h){
      r_part = r[ ((x-1)*w + 1)  :(x*w) , ((y-1)*h + 1)  :(y*h)  ,1:2]
 
      
    name = paste0(strsplit(label, '[.]')[[1]][1], '_', x, '_', y, '.rds')
  saveRDS(r_part, file.path('db', 'labels', name))
  }}
  
}






############################
for(file in files){
  r = stack(file.path('db', 'clouds', file))
  r = as.array(r)
  r= r/ 12208
  
  parts_w = floor(dim(r)[1]/ w)
  parts_h = floor(dim(r)[2]/ h) 
  
  for(x in 1:parts_w){
    for(y in 1:parts_h){
      r_part = r[ ((x-1)*w + 1)  :(x*w) , ((y-1)*h + 1)  :(y*h)  ,1:4]
     
        name = paste0(strsplit(file, '[.]')[[1]][1], '_', x, '_', y, '.rds')
            saveRDS(r_part, file.path('db', 'images', name))
    }}
  
}





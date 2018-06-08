labels = list.files('db/labels_parts')
dir_out = 'db/trainingdata'


library(feather)
library(EBImage)

class = 39L
w = 512
h = 512

for(label in labels){

input_lab = as.matrix(read_feather( file.path('db/labels_parts', label) )) +1


input_lab  = apply(input_lab,c(1,2), function(x){
  z = rep(0, class)
  z[x] = 1
 z
  
})

input_lab = aperm(input_lab, c(2,3,1))
input_lab = array(input_lab, dim = c(1, dim(input_lab)))  

saveRDS(input_lab, paste0(dir_out, '/label_', gsub(label,pattern = '.fe', replacement = ''), '.rds'))

input_im = readImage( file.path('db/images_parts', gsub(label,pattern = '.fe', replacement = '.jpg'))  )
input_im = array(input_im, dim = c(1, dim(input_im)))
extra = array(input_lab, dim = c(1,w,h, 1))
input_im = abind(input_im, extra, along = 4)

saveRDS(input_im, paste0(dir_out, '/image_', gsub(label,pattern = '.fe', replacement = '') , '.rds'))
  
}





labels = list.files('db/labels_parts')
dir_out = 'db/onehot'


library(feather)
library(EBImage)

class = 39L
w = 512
h = 512

i = 1



labels_total = as.matrix(read_feather( file.path('db/labels_parts', labels[i] ) )) +1


labels_total  = apply(labels_total,c(1,2), function(x){
  z = rep(0, class)
  z[x] = 1
  z
  
})



labels_total = aperm(labels_total, c(2,3,1))
labels_total = array(labels_total, dim = c(1, dim(labels_total)))  



im_total = readImage( file.path('db/images_parts', gsub(labels[i],pattern = '.fe', replacement = '.jpg'))  )
im_total = array(im_total, dim = c(1, dim(im_total)))
extra = array(labels_total, dim = c(1,w,h, 1))
im_total = abind(im_total, extra, along = 4)











for(i  in 2:length(labels)){
  print(i / length(labels))
label = labels[i]
input_lab = as.matrix(read_feather( file.path('db/labels_parts', label) )) +1


input_lab  = apply(input_lab,c(1,2), function(x){
  z = rep(0, class)
  z[x] = 1
 z
  
})

input_lab = aperm(input_lab, c(2,3,1))
input_lab = array(input_lab, dim = c(1, dim(input_lab)))  


labels_total = abind(labels_total, input_lab, along = 1)
#saveRDS(input_lab, paste0(dir_out, '/label_', gsub(label,pattern = '.fe', replacement = ''), '.rds'))

input_im = readImage( file.path('db/images_parts', gsub(label,pattern = '.fe', replacement = '.jpg'))  )
input_im = array(input_im, dim = c(1, dim(input_im)))
extra = array(input_lab, dim = c(1,w,h, 1))
input_im = abind(input_im, extra, along = 4)

im_total = abind(im_total, input_im, along = 1)

#saveRDS(input_im, paste0(dir_out, '/image_', gsub(label,pattern = '.fe', replacement = '') , '.rds'))
  
}

saveRDS(labels_total, 'db/labels.rds')

saveRDS(images_total, 'db/images.rds')




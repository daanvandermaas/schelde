library(keras)
library(EBImage)
library(feather)

dir_out = 'db/predictions'

class = 39L
h = as.integer(512) #heigth image dim image = 2448
w = as.integer(512) #width image

model = keras::load_model_hdf5('db/models/model_23')

data = readRDS('db/train.rds')


for(i in 1:nrow(data)){
  
  print(i)
  input_im = readImage(data$files[i])
  input_im = array(input_im, dim = c(1, dim(input_im)))
  
  input_lab = as.matrix(read_feather(data$labels[i])) +1
  
  input_lab  = apply(input_lab, c(1,2), function(x){
    z = rep(0, class)
    z[x] = 1
    z
  })
  
  input_lab = aperm(input_lab, c(2,3,1))
  input_lab = array(input_lab, dim = c(1, dim(input_lab)))  
  
  extra = array(input_lab, dim = c(1,w,h, 1))
  input_im = abind(input_im, extra, along = 4)
  
  
pred =   model$predict(x = input_im)

pred  = apply(pred, c(1,2,3), function(x){
  which(max(x) == x)[1] - 1
})  

pred =  pred[1,,]
pred = as.data.frame(pred)
name =  file.path('db', 'predictions',  paste0(strsplit(data$labels[i], '[/.]')[[1]][3], '_pred.fe') )
write_feather( pred, name)

}
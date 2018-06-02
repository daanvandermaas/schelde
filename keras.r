library(keras)
library(EBImage)
library(feather)

source('read_batch.r')


#data loading
train = readRDS( file.path(getwd(), 'db', 'train.rds'))



######Parameters
epochs = 280
batch_size = 1L
parts = 4
  h = as.integer(512) #heigth image dim image = 2448
w = as.integer(512) #width image
channels = 4L
class = 39L
pick = 100L
#####

# encoding layers


source('Unet.r')

opt<-optimizer_adam( lr= 0.0001 , decay = 0,  clipnorm = 1 )

compile(model, loss="categorical_crossentropy", optimizer=opt, metrics = "accuracy")





#Train the network
for (epoch in 1:epochs){
  order = sample(c(1:nrow(train) ), nrow(train))
  train = train[order,]
  

  
  
  for(i in 1:nrow(train)){
  

  input_im = readImage(train$files[i])
  input_im = array(input_im, dim = c(1, dim(input_im)))
  
  input_lab = as.matrix(read_feather(train$labels[i])) +1

  input_lab  = apply(input_lab, c(1,2), function(x){
    z = rep(0, class)
    z[x] = 1
    z
  })
  
input_lab = aperm(input_lab, c(2,3,1))
input_lab = array(input_lab, dim = c(1, dim(input_lab)))  

extra = array(input_lab, dim = c(1,w,h, 1))
input_im = abind(input_im, extra, along = 4)

  model$fit( x= input_im, y= input_lab, batch_size = batch_size, epochs = 1L )
  
  }
  print(paste('epoch:', epoch))
    model$save( paste0('db/model/model_', epoch) )
    
  
  
  
}


#model$evaluate(x = batch_files, y = batch_labels)

#model = keras::load_model_hdf5('db/model_89')
library(keras)
library(EBImage)
library(feather)

source('read_batch.r')


#data loading
train = readRDS( file.path(getwd(), 'db', 'train.rds'))



######Parameters
epochs = 280
batch_size = 4L
parts = 4
  h = as.integer(608) #heigth image dim image = 2448
w = as.integer(608) #width image
channels = 3L
class = 7L
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
  
  input_lab = as.matrix(read_feather(train$labels[i]))

  input_lab  = apply(input_lab, c(1,2), function(x){
    
    rep(0, class)
    
  })
  
input_lab = aperm(input_lab, c(2,3,1))
  
  model$fit( x= batch_files, y= batch_labels, batch_size = batch_size, epochs = 1L )
  
  }
  print(paste('epoch:', epoch))
    model$save( paste0('db/model/model_', epoch) )
    
  
  
  
}


#model$evaluate(x = batch_files, y = batch_labels)

#model = keras::load_model_hdf5('db/model_89')
#a linear stack of layers
library(jpeg)
library(tensorflow)
library(keras)
library(EBImage)
library(raster)


source('read_batch.r')
source('read_labels_select.r')
source('augement.r')
source('augment_labels.r')


#data loading
train = readRDS( file.path(getwd(), 'db', 'landuse', 'train.rds'))
train$images = file.path(getwd(), 'db', 'landuse', 'land-train', train$images)
train$labels = file.path(getwd(), 'db', 'landuse', 'label-train', paste0(train$labels, '_mask.rds'))



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
  
  windows = c(1:parts^2)
  rot = sample(x = c(0,1,2,3), size = 1)
  flip = sample(x = c(TRUE, FALSE), size = 1)
  
  batch_files = read_batch(files = train$images[i], format = 'jpg', channels = channels, windows = windows, parts=parts, w= w, h=h, rot = rot, flip, aug = TRUE)
  batch_labels =  read_labels_select(files = train$labels[i], windows = windows, class = class, parts=parts, w=w, h=h, pick = pick, flip, aug = TRUE)

  
  model$fit( x= batch_files, y= batch_labels, batch_size = batch_size, epochs = 1L )
  
  }
  print(paste('epoch:', epoch))
    model$save( paste0('db/model/model_', epoch) )
    
  
  
  
}


#model$evaluate(x = batch_files, y = batch_labels)

#model = keras::load_model_hdf5('db/model_89')
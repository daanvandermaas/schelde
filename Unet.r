input_img = layer_input(shape = c(w, h, channels)) 


l0 = layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(input_img) 
l0 = layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l0)

l1 = layer_max_pooling_2d(pool_size = c(2,2))(l0)
l1 = layer_conv_2d( filter=128, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1) 
l1 = layer_conv_2d( filter=128, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1)

l2 = layer_max_pooling_2d(pool_size = c(2,2))(l1)
l2 = layer_conv_2d( filter=256, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2) 
l2 = layer_conv_2d( filter=256, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2)

l3 = layer_max_pooling_2d(pool_size = c(2,2))(l2)
l3 = layer_conv_2d( filter=512, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3) 
l3 = layer_conv_2d( filter=512, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3)

l4 = layer_max_pooling_2d(pool_size = c(2,2))(l3)
l4 = layer_conv_2d( filter=1024, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l4) 
l4 = layer_conv_2d( filter=1024, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l4)


l3_up = layer_conv_2d_transpose(  filters = 512 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l4)
l3_up = layer_concatenate( list(l3,l3_up))
l3_up = layer_conv_2d( filter=512, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3_up) 
l3_up = layer_conv_2d( filter=512, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l3_up)

l2_up = layer_conv_2d_transpose(  filters = 256 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l3_up)
l2_up = layer_concatenate( list(l2,l2_up))
l2_up = layer_conv_2d( filter=256, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2_up) 
l2_up = layer_conv_2d( filter=256, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l2_up)


l1_up = layer_conv_2d_transpose(  filters = 128 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l2_up)
l1_up = layer_concatenate( list(l1,l1_up))
l1_up = layer_conv_2d( filter=128, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1_up) 
l1_up = layer_conv_2d( filter=128, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l1_up)

l0_up = layer_conv_2d_transpose(  filters = 64 , kernel_size=c(3,3) ,strides = c(2L, 2L), padding="same")(l1_up)
l0_up = layer_concatenate( list(l0,l0_up))
l0_up = layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l0_up) 
l0_up = layer_conv_2d( filter=64, kernel_size=c(3,3),padding="same",     activation = 'relu' )(l0_up)

output = layer_conv_2d( filter=class, kernel_size=c(1,1),padding="same",     activation = 'softmax' )(l0_up)


model = keras_model(inputs = input_img, outputs = output)



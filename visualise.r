
library(raster)
library(feather)
library(ggplot2)


path = 'db/labels_parts'

labels = list.files(path)
path_out = 'db/labels_parts_visualise'

visualise_labels(path, labels, path_out )

visualise_labels = function(path , labels, path_out){

cols <- c(
  '0' = "black", #niks
  '1' = "yellow", #D1
  '2' = "chartreuse", #D2   
  '3' = "chartreuse1", #H1a
  '4' = "chartreuse2", #H1b
  '5' = "chartreuse3", #H2a  
  '6' = "darkolivegreen2", #H2b
  '7' = "darkolivegreen3", #H2d  
  '36' = '',#O1
  '8' = "darkolivegreen1", #O2
  '9' = "gold2",  #O3
  '37' = '',#O4
  '10' = "gold3", # O5
  '11' = "gold", #P1a1
  '12' = 'gold2', #P1a2
  '13' = 'gold4', #P1a3
  '14' = "brown", #P1b
  '15' = "brown2", #P2a
  '16' = "brown1", #P2b1
  '17' = "brown3", #P2b2    
  '18' = "aquamarine4", # P2c 
  '19' = "aquamarine3", # P2d1
  '20' = "aquamarine2", #P2d2
  '21' = "aquamarine", # P2d3  
  '22' = 'yellow1', #S1a
'23' = 'blue', #S1c
'24' = '',  #S2a
 '25' = '', # S2b
'26' = '', #S3a
'27' = '',#H1ah
'28' = '',#H1bh
'29' = '',#H2c
'30' = '',#K1a1
'31' = '',#K1a2
'32' = '',#K2a
'33' = '',#K2b1
'34' = '',#K2b2
'35' = '',#K2c
'38' = '',#P3
)



for(i in 1:length(labels)){

  lab = read_feather(file.path(path, labels[i]))
  lab = as.matrix(lab)
  name = paste0( file.path(path_out, strsplit(labels[i],'[.]')[[1]][1]), '.png')


png(name)
print({
par(mar=c(0,0,0,0))
image(as.matrix(lab), col= cols[ names(cols) %in% lab ], xaxt = 'n', yaxt = 'n')
})
dev.off()
}

}


library(raster)
library(feather)
library(ggplot2)


path = 'db/labels_parts'

labels = list.files(path)
path_out = 'db/labels_parts_visualisatie'

visualise_labels(path, labels, path_out )

visualise_labels = function(path , labels, path_out){

  #D Duin geel maar een paar
  #O overig grijs
  #kwelders groen S
  #hard subtraat bruin H Paars
  #Schorkelen groen K
  #platen rood P
  
cols <- c(
  '0' = "black", #niks
  '1' = "yellow", #D1
  '2' = "yellow1", #D2   
  '3' = "magenta", #H1a
  '4' = "magenta1", #H1b
  '5' = "magenta2", #H2a  
  '6' = "magenta3", #H2b
  '7' = "magenta4", #H2d 
  '27' = 'orchid',#H1ah
  '28' = 'orchid1',#H1bh
  '29' = 'orchid2',#H2c
  '36' = 'snow',#O1
  '8' = "snow1", #O2
  '9' = "snow2",  #O3
  '37' = 'snow3',#O4
  '10' = "snow4", # O5
  '11' = "red", #P1a1
  '12' = 'red1', #P1a2
  '13' = 'red2', #P1a3
  '14' = "red3", #P1b
  '15' = "red4", #P2a
  '16' = "darkorange", #P2b1
  '17' = "darkorange1", #P2b2    
  '18' = "darkorange3", # P2c 
  '19' = "darkorange4", # P2d1
  '20' = "darkred", #P2d2
  '21' = "chocolate", # P2d3 
  '38' = 'chocolate1',#P3
  '22' = 'gold', #S1a
'23' = 'chartreuse', #S1c
'24' = 'chartreuse1',  #S2a
 '25' = 'chartreuse2', # S2b
'26' = 'chartreuse3', #S3a
'30' = 'chartreuse4',#K1a1
'31' = 'aquamarine',#K1a2
'32' = 'aquamarine1',#K2a
'33' = 'aquamarine2',#K2b1
'34' = 'aquamarine3',#K2b2
'35' = 'aquamarine4'#K2c
)



for(i in 1:length(labels)){
print(i/ length(labels))
  
lab = read_feather(file.path(path, labels[i]))
  lab = as.matrix(lab)
  lab = lab[,dim(lab)[2]:1]
  name = paste0( file.path(path_out, strsplit(labels[i],'[.]')[[1]][1]), '.png')

png(name)
print({
par(mar=c(0,0,0,0))
image(as.matrix(lab), col= cols[ names(cols) %in% lab ], xaxt = 'n', yaxt = 'n')
})
dev.off()
}

}

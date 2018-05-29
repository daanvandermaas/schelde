
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
  '1' = "yellow", # Antropogene duinen (stuifdijken etc.)     
  '2' = "yellow3", # Antropogene duinen (stuifdijken etc.)   
  '3' = "gold", # Hard substraat, veen-/kleibanken (onbegroeid) < 25% zandbedekking antropogene sporen        
  '4' = "gold1", #Hard substraat, veen-/kleibanken (onbegroeid) > 25% zandbedekking antropogene sporen  
  '5' = "gold2",  #Hard substraat antropogeen (glooiing, krib etc) dijkglooiing  
  '6' = "gold3", # Hard substraat antropogeen (glooiing, krib etc) krib havendam    
  '7' = "gold4", #Hard substraat antropogeen (glooiing, krib etc) vooroever / schorrandverdediging   
  '8' = "deeppink", #Overig plateau/verhoging (antropogeen)  
  '9' = "deeppink1", # Overig wegen/paden     
  '10' = "deeppink2", # Overig waterberging  
  '11' = "aquamarine", # Laag energetische vlakke plaat, zand  
  '12' = "aquamarine2", #Laag energetische vlakke plaat, slibrijk zand (> 8% lutum)    
  '13' = "aquamarine3", # Laag energetische vlakke plaat, met laagje water
  '14' = "aquamarine4", # Laag energetische plaat met laag golvend relief (H < 0,25m, L = 10-25m)   
  '15' = "brown", #Hoog energetische plaat gegolfd relief (H < 0,25m, L >25m)      
  '16' = "brown1", #Hoog energetische plaat met regelmatige 2-dimensionale megaribbels (H > 0,25m) 
  '17' = "brown2", #Hoog energetische plaat met onregelmatige 3-dimensionale megaribbels (H > 0,25m)        
  '18' = "brown3", #Hoog energetische vlakke plaat    
  '19' = "darkolivegreen1", #(Geisoleerde) zandrug op hoog energetische plaat 
  '20' = "darkolivegreen2", #(Geisoleerde) schelpenrug op hoog energetische plaat 
  '21' = "darkolivegreen3", #(Geisoleerde) schelpenrug op hoog energetische plaat langs dijk    
  '22' = "chartreuse", #Begroeid schor/strand (gesloten, > 50 % bedekking) natuurlijke (kwelder)vorm      
  '23' = "chartreuse1", #Begroeid schor/strand (gesloten, >50 % bedekking) open plek in het kwelder (< 25% bedekking)
  '24' = "chartreuse2", # Begroeid schor/strand (open, 10-50% bedekking) natuurlijke (kwelder)vorm 
  '25' = "chartreuse3", #Begroeid schor/strand (zeer open, < 10% bedekking en/of pollenstructuur (> 10 pollen/ha)   
  '26' = "blue" # Natuurlijk meanderende kreek (10-250m breed, onbegroeid) op schor/kwelder en groen strand   
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

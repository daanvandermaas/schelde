path_labels = 'db/trainingdata'
path_files = 'db/images_parts'
ext_labels = '.fe'
ext_im = '.jpg'

labels = list.files(path_labels)


i=1
dim(readRDS(file.path(path_labels, labels[i])))


files = gsub(labels, pattern = ext_labels, replacement =  ext_im)
labels = file.path(path_labels, labels)
files = file.path(path_files, files)

data = data.frame('files'=  files, 'labels'=  labels, stringsAsFactors = FALSE)


split = sample(x =  c(1:nrow(data)), size = round(0.8*nrow(data)) )
train = data[split,]
test = data[-split,]


saveRDS(train, file.path('db', 'train.rds'))
saveRDS(test, file.path('db', 'test.rds'))






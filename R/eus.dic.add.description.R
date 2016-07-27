eus.dic.add.description = function(dataset, dic.name){
  dic = eus.dic.load(dic.name)
  col.name = paste(dic.name, 'description', sep='.')
  print(col.name)
  print(colnames(dataset$data))
  dataset$data[[col.name]] = eus.dic.load(dic.name)[dt$data[[dic.name]]]
}

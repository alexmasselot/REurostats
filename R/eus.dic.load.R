.cache.dic = list()

eus.dic.load = function(dic.name){
  if(is.null(.cache.dic[[dic.name]])){
    filename = system.file("extdata/dic/", paste(dic.name,'.dic', sep=''), package = "REurostats")
    if(filename == ''){
      stop(paste("no dictionary file found in package for ", dic.name));
    }
    dt = read.delim(filename, sep='\t', header=F)

    dt = dt[!is.na(dt[,1]),]
    descr = as.character(dt[,2])
    names(descr) = dt[,1]

    .cache.dic[[dic.name]] = descr
  }
  .cache.dic[[dic.name]]
}

.cache.dic = list()

eus.dic.load = function(dic.name){
  if(is.null(.cache.dic[[dic.name]])){
    filename = system.file("extdata/dic/", paste(dic.name,'.dic', sep=''), package = "REurostats")
    if(filename == ''){
      stop(paste("no dictionary file found in package for ", dic.name));
    }
    dt = read.delim(filename, sep='\t', header=F)
    rownames(dt)=dt[,1]
    colnames(dt)=c('key', 'description')
    .cache.dic[[dic.name]] = dt
  }
  .cache.dic[[dic.name]]
}

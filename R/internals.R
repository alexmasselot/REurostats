library(XML)
.toc.xml = NULL
.eus.toc.load.xml = function(){
  if(is.null(.toc.xml)){
    filename = system.file("extdata", 'table_of_contents.xml', package = "REurostats")
    .toc.xml <<- xmlInternalTreeParse(filename)
  }
  .toc.xml
}

eus.toc.get.description.lineage = function(dataset.name){
  doc = .eus.toc.load.xml()
  special_nodes <- getNodeSet(doc, paste('//nt:code[text()="',dataset.name,'"]', sep=''))
  n = special_nodes[[1]]

  cDescrLineage = c()
  ancestors = xmlAncestors(n)
  for( nParent in xmlAncestors(n)) {
    for(elTitle in xmlElementsByTagName(nParent, 'title')){
      attr = xmlAttrs(elTitle)
      if(attr['language'] == 'en'){
        cDescrLineage = c(xmlValue(elTitle), cDescrLineage)
      }
    }
  }
  print(cDescrLineage)
  cDescrLineage
}

#REurostats
An R package to download Eurostats data

Head to the example directory 

## How to load Eurostats data
Eurostats [table of contents](http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&file=table_of_contents_en.pdf) gives details on the list of dataset.

There should be some http loading and buffering.
And we maybe don't want to commit all of them to gitlab
For the moment, let's download them all in inst/extdata (th ecommand below will not redownoad the file if it already exists)

    cd /inst/extdata
    #get the xml table of content (from which description and lineage will be extracted)
    wget -O table_of_contents.xml "http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&downfile=table_of_contents.xml"
    
    #get the index of all dataset
    wget -O eurostats-bulk.html "http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?dir=data&sort=1&sort=2&start=all"
    
    #parse the html index to get the actual url and download them if they do not yet exists locally
    mkdir -p data
    cd data
    for u in $(grep '>Download<' ../eurostats-bulk.html | cut -f24 -d'"' | sed 's/amp;//g') ; do 
      f=$(echo $u | cut -c100-1000) 
      if [ -f $f ]; then 
        echo $f
      else 
        echo $f $u
        wget  -qO $f "$u"
      fi
    done
    cd ..
    
    #get the dictionaries (just a few for the moment)
    mkdir -p dic
    cd dic
    for s in indic s_adj geo
    do
      echo $s
      wget -Oq $s.dic "http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&file=dic%2Fen%2F$s.dic"
    done
    cd ..

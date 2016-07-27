#REurostats
An R package to download Eurostats data

Head to the example directory 

## How to load Eurostats data
Eurostats [table of contents](http://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&file=table_of_contents_en.pdf) gives details on the list of dataset.

There should be some http loading and buffering.
And we maybe don't want to commit all of them to gitlab
For the moment, let's download them all in inst/extdata (th ecommand below will not redownoad the file if it already exists)

    for u in $(grep '>Download<' ../eurostats-bulk.html | cut -f24 -d'"' | sed 's/amp;//g') ; do 
      f=$(echo $u | cut -c100-1000) 
      if [ -f $f ]; then 
        echo $f
      else 
        echo $f $u
        wget  -qO $f "$u"
      fi
    done

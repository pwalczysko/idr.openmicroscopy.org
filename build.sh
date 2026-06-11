#! /bin/sh
# Script to build the idr.openmicroscopy.org website using Docker

set -e
set -u

docker run --rm -v $PWD:/srv/jekyll -eJEKYLL_UID=$UID jekyll/builder:pages jekyll build --config _config.yml,_prod.yml
docker run --rm -v $PWD/_site:/site/about jekyll/builder:pages /usr/gem/bin/htmlproofer /site --ignore-urls "/jupyter/,/filezilla-project.org/,/webclient/,/cell/,/tissue/,/login.binder.bioimagearchive.org/,/biii.eu/,/ncbi.nlm.nih.gov/,/localhost/,/github.com/" --only_4xx --no-enforce-https --allow-missing-href --ignore-status-codes "400,404" --typhoeus='{
  "headers":{
    "User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Brave Chrome/91.0.4472.164 Safari/537.36"
  },
  "timeout":20,
  "connecttimeout":10,
  "accept_encoding":"gzip"
}'

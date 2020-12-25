#!/bin/bash

docker run --rm -d -p 8983:8983 --name solrbee-test solr:8 solr-precreate solrbee

while ! curl -fs http://localhost:8983/solr/solrbee/admin/ping 2>/dev/null ;
do sleep 1
done

SOLR_URL=http://localhost:8983/solr/solrbee bundle exec rake
code=$?

docker stop solrbee-test

exit $code

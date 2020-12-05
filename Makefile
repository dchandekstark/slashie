SHELL = /bin/bash

.PHONY : test
test:
	docker run --rm -d -p 8983:8983 --name solrbee-test solr:8 solr-precreate solrbee
	while ! curl -fs http://localhost:8983/solr/solrbee/admin/ping 2>/dev/null ; do sleep 1 ; done
	bundle exec rake
	docker stop solrbee-test

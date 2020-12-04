SHELL = /bin/bash

.PHONY : test
test:
	bundle exec rake


.PHONY : start-test-server
start-test-server:
	docker run --rm -d -p 8983:8983 --name solrbee-test solr:8 solr-precreate solrbee

.PHONY : stop-test-server
stop-test-server:
	docker stop solrbee-test

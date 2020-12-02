SHELL = /bin/bash

.PHONY : test
test:
	docker run --rm -d --name solrbee-test solr:8 solr-precreate solrbee
	bundle exec rake
	docker stop solrbee-test

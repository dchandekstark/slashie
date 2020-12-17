require 'rom-http'

require 'rom/solr/response'
require 'rom/solr/request'
require 'rom/solr/dataset'
require 'rom/solr/relation'
require 'rom/solr/gateway'

module ROM
  module Solr

  end
end

ROM.register_adapter(:solr, ROM::Solr)

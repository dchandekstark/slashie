require 'rom-http'

require_relative 'solr/request'
require_relative 'solr/response'
require_relative 'solr/dataset'
require_relative 'solr/select_dataset'
require_relative 'solr/gateway'
require_relative 'solr/relation'
require_relative 'solr/select_relation'

module ROM
  module Solr
  end

  register_adapter(:solr, ROM::Solr)
end

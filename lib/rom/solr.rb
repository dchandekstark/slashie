require 'rom-http'

require_relative 'solr/request_handler'
require_relative 'solr/response_handler'

require_relative 'solr/dataset'
require_relative 'solr/datasets/select_dataset'

require_relative 'solr/gateway'

require_relative 'solr/select_cursor'

require_relative 'solr/relation'
require_relative 'solr/relations/select_relation'
require_relative 'solr/relations/schema_relation'

module ROM
  module Solr

    def self.configuration
      @configuration ||= ROM::Configuration.new(:solr) do |config|
        config.register_relation(
          SelectRelation,
          SchemaInfoRelation
        )
      end
    end
  end

  register_adapter(:solr, Solr)
end

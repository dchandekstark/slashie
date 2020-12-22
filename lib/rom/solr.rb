require 'rom-http'

# Utilities
require_relative 'solr/array'
require_relative 'solr/select_cursor'
require_relative 'solr/response_value'
require_relative 'solr/query_param'

# Handlers
require_relative 'solr/request_handler'
require_relative 'solr/response_handler'

# Datasets
require_relative 'solr/dataset'
require_relative 'solr/select_dataset'

# Gateway
require_relative 'solr/gateway'

# Relations
require_relative 'solr/relation'
require_relative 'solr/select_relation'
require_relative 'solr/schema_info_relation'

# Repositories
require_relative 'solr/schema_info'

module ROM
  module Solr

    def self.configuration
      @configuration ||= ROM::Configuration.new(:solr) do |config|
        config.register_relation(SelectRelation)
        config.register_relation(SchemaInfoRelation)

        # config.relation(:schema_info) do
        #   schema(:schema, as: :schema_info) { }
        # end

        # config.relation(:schema_fields) do
        #   schema('schema/fields', as: :schema_fields
        # end
      end
    end

  end
end

ROM.register_adapter(:solr, ROM::Solr)

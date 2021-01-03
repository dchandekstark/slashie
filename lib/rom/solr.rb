require 'securerandom'
require 'date'
require 'time'

require 'rom-http'

module ROM
  module Solr

    def self.dataset_class(name)
      prefix = name.to_s.split(/[_\/]/).map(&:capitalize).join('')
      const_name = "#{prefix}Dataset"
      const_defined?(const_name, false) ? const_get(const_name, false) : Dataset
    end

    # Applies quoting to values as necessary for Solr query processing.
    #
    # @param value [String] the raw value to be quoted
    # @return [String] the value with quoting applied (if necessary).
    def self.quote(value)
      # Derived from Blacklight::Solr::SearchBuilderBehavior#solr_param_quote
      unless value =~ /\A[a-zA-Z0-9$_\-\^]+\z/
        '"' + value.gsub("'", "\\\\\'").gsub('"', "\\\\\"") + '"'
      else
        value
      end
    end

    # Formats a value as a Solr date.
    def self.date(value)
      DateTime.parse(value.to_s).to_time.utc.iso8601
    end

    module Types
      include ROM::HTTP::Types
    end

    UUID = Types::String.default { SecureRandom.uuid }

  end
end

# Utilities
require 'rom/solr/array'

# Handlers
require 'rom/solr/request_handler'
require 'rom/solr/response_handler'

# Datasets
require 'rom/solr/dataset'
require 'rom/solr/documents_dataset'
require 'rom/solr/schema_info_dataset'

# Gateway
require 'rom/solr/gateway'

# Schemas
require 'rom/solr/schema'

# Relations
require 'rom/solr/relation'

# Repositories
require 'rom/solr/repository'
require 'rom/solr/schema_info_repo'
require 'rom/solr/document_repo'

# Commands
require 'rom/solr/commands'

ROM.register_adapter(:solr, ROM::Solr)

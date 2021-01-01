require 'rom-http'
require 'securerandom'

module ROM
  module Solr

    def self.dataset_class(name)
      prefix = name.to_s.split(/[_\/]/).map(&:capitalize).join('')
      const_name = "#{prefix}Dataset"
      const_defined?(const_name, false) ? const_get(const_name, false) : Dataset
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

require 'rom-http'

# Utilities
require_relative 'solr/array'
require_relative 'solr/select_cursor'

# Handlers
require_relative 'solr/request_handler'
require_relative 'solr/update_request_handler'
require_relative 'solr/response_handler'

# Datasets
require_relative 'solr/dataset'
require_relative 'solr/select_dataset'
require_relative 'solr/update_dataset'

# Gateway
require_relative 'solr/gateway'

# Relations
require_relative 'solr/relation'
require_relative 'solr/search_relation'
require_relative 'solr/schema_info_relation'

# Repositories
require_relative 'solr/repository'
require_relative 'solr/schema_info_repo'
require_relative 'solr/search_repo'

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

  end
end

ROM.register_adapter(:solr, ROM::Solr)

require 'solrbee/version'

require 'dry-types'
require 'rom/solr'

module Solrbee

  DEFAULT_URI = ENV.fetch('SOLR_URL', 'http://localhost:8983/solr').freeze

  def self.documents
    ROM::Solr::DocumentRepo.new(container)
  end

  def self.schema_info
    ROM::Solr::SchemaInfoRepo.new(container)
  end

  def self.container(uri: DEFAULT_URI)
    ROM.container(:solr, uri: uri) do |config|
      config.auto_registration(
        File.expand_path('../rom/solr/', __FILE__),
        namespace: 'ROM::Solr'
      )

      yield config if block_given?
    end
  end

  module Types
    include Dry.Types()
  end

end

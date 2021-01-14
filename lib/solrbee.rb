require 'logger'

require 'solrbee/version'

require 'dry-types'
require 'rom/solr'

module Solrbee

  DEFAULT_URI = ENV.fetch('SOLR_URL', 'http://localhost:8983/solr').freeze

  LOG_LEVEL = ENV.fetch('SOLRBEE_LOG_LEVEL', 'DEBUG')

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

      config.register_command *(ROM::Solr::ModifySchema.commands)

      yield config if block_given?
    end
  end

  def self.logger
    @logger ||= Logger.new(STDOUT, level: Logger.const_get(LOG_LEVEL))
  end

  module Types
    include Dry.Types()
  end

end

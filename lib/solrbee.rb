require "solrbee/version"

require "rom/solr"

module Solrbee

  def self.uri
    ENV.fetch('SOLR_URL', 'http://localhost:8983/solr')
  end

  def self.documents
    rom = container do |config|
      config.register_relation(ROM::Solr::DocumentsRelation)
    end

    ROM::Solr::DocumentRepo.new(rom)
  end

  def self.schema_info
    rom = container { |config| config.register_relation(ROM::Solr::SchemaInfoRelation) }

    ROM::Solr::SchemaInfoRepo.new(rom)
  end

  def self.container
    ROM.container(:solr, uri: uri) do |config|
      yield config if block_given?
    end
  end

end

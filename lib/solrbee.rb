require "solrbee/version"

require "rom/solr"

module Solrbee

  def self.uri
    ENV.fetch('SOLR_URL', 'http://localhost:8983/solr')
  end

  # Factory method
  #
  # @return [ROM::Solr::Documents] a relation for searching
  def self.documents
    rom = container do |config|
      config.register_relation(ROM::Solr::DocumentsRelation)
      config.register_command(ROM::Solr::Commands::CreateDocuments)
      config.register_command(ROM::Solr::Commands::Commit)
    end

    ROM::Solr::DocumentRepo.new(rom)
  end

  # Factory method
  #
  # @return [ROM::Solr::SchemaInfo] a relation for schema info
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

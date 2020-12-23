require "solrbee/version"

require "rom/solr"

module Solrbee

  # Factory method
  #
  # @return [ROM::Solr::SelectRelation] a relation for searching
  def self.search
    rom = container { |config| config.register_relation(ROM::Solr::SearchRelation) }
    ROM::Solr::SearchRepo.new(rom)
  end

  # Factory method
  #
  # @return [ROM::Solr::SchemaInfoRelation] a relation for schema info
  def self.schema_info
    rom = container { |config| config.register_relation(ROM::Solr::SchemaInfoRelation) }
    ROM::Solr::SchemaInfoRepo.new(rom)
  end

  def self.container
    ROM.container(:solr,
                  uri: ENV.fetch('SOLR_URL', 'http://localhost:8983/solr'),
                  headers: { Accept: 'application/json' }
                 )
  end

end

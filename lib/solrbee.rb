require "solrbee/version"
require "solrbee/array"
require "solrbee/mash"
require "solrbee/api"
require "rom/solr"

module Solrbee

  # Factory method
  #
  # @return [ROM::Solr::Gateway] a gateway instance
  def self.gateway
    ROM::Gateway.setup(:solr)
  end

  # Factory method
  #
  # @return [Solrbee::Documents] a ROM relation for searching
  def self.documents
    container.relations[:search]
  end

  def self.schema
    container.relations[:schema_info]
  end

  # @return [ROM::Configuration] configuration
  def self.config
    @config ||= ROM::Configuration.new(:solr) do |config|
      config.register_relation(
        ROM::Solr::SelectRelation,
        ROM::Solr::SchemaRelation
      )
    end
  end

  def self.container
    ROM.container(config)
  end

end

require "solrbee/version"

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
  # @return [ROM::Solr::SelectRelation] a relation for searching
  def self.search
    container.relations[:search]
  end

  # Factory method
  #
  # @return [ROM::Solr::SchemaInfoRelation] a relation for schema info
  def self.schema_info
    ROM::Solr::SchemaInfo.new(container)
  end

  def self.configuration
    @configuration ||= ROM::Configuration.new(:solr) do |config|
      config.register_relation(ROM::Solr::SelectRelation)
      config.register_relation(ROM::Solr::SchemaInfoRelation)
    end
  end

  def self.container
    ROM.container(configuration)
  end

end

require "solrbee/version"
require "solrbee/array"

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
    container.relations[:schema_info]
  end

  def self.api
    @api ||= YAML.load_file(File.expand_path('../../config/api.yml', __FILE__))
  end

  def self.container
    ROM.container(ROM::Solr.configuration)
  end

end

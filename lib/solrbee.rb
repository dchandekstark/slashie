require "solrbee/version"
require "rom/solr"

module Solrbee

  def self.gateway
    ROM::Gateway.setup(:solr)
  end

  # @return [Solrbee::Documents] a ROM relation
  def self.documents
    container.relations[:select]
  end

  # @return [ROM::Configuration] configuration
  def self.configuration
    ROM::Configuration.new(:solr) do |config|
      config.register_relation(ROM::Solr::SelectRelation)
    end
  end

  def self.container
    ROM.container(configuration)
  end

end

# require "solrbee/api"
# require "solrbee/query"
# require "solrbee/cursor"
# require "solrbee/client"

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

  def self.api
    @api ||= YAML.load_file(File.expand_path('../../config/api.yml', __FILE__))
  end

  def self.container
    @container ||= ROM.container(:solr) do |rom|
      rom.relation(:schema) do
        schema(:schema, as: :schema_info) { }
        auto_map false
        option :output_schema, default: ->{ ROM::Relation::NOOP_OUTPUT_SCHEMA }

        Solrbee.api['schema']['methods'].each do |name, config|
          next if method_defined?(name) && !!config['override']

          define_method(name) do |*args, **kwargs|
            args_hash = config['args'].to_a.map(&:to_sym).zip(args).to_h
            params = config['params'].to_h.merge(kwargs)
            path = config.key?('path') ? config['path'] % args_hash : nil
            with_path(path).add_params(params)
          end
        end
      end
    end
  end

end

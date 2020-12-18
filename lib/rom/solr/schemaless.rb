require "hashie"

module ROM
  module Solr
    module Schemaless

      def self.extended(base)
        schemaless_output = Class.new(Hashie::Mash) do
          include Hashie::Extensions::Mash::SymbolizeKeys
          disable_warnings
        end
        base.const_set(:SchemalessOutput, schemaless_output)
        base.option :output_schema, default: ->{ self.class.const_get(:SchemalessOutput) }
      end

      def schemaless(*args)
        schema(*args) do
          # no schema :)
        end
      end

    end
  end
end

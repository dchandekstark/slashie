# frozen_string_literal: true

require 'rom/solr/query'

module ROM
  module Solr
    class QueryBuilder

      attr_accessor :queries

      def initialize(queries = [])
        @queries = queries
      end

      def to_a
        queries
      end

      Query.public_instance_methods.each do |name|
        define_method(name) do |*args|
          self.queries += Query.send(name, *args)
        end
      end

    end
  end
end

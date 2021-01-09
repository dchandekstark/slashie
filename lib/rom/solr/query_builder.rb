require 'rom/solr/query'

module ROM
  module Solr
    class QueryBuilder
      include Utils

      AND = '&&'
      OR  = '||'

      attr_accessor :queries

      def self.call(&block)
        new.instance_eval(&block).to_a
      end

      def initialize(queries = [])
        @queries = queries
      end

      def to_a
        queries
      end

      def raw(*queries)
        self.queries += queries
      end

      def And(&block)
        queries = QueryBuilder.call(&block)

        self.queries << '(%s)' % queries.join(" #{AND} ")
      end

      def Or(&block)
        queries = QueryBuilder.call(&block)

        self.queries << '(%s)' % queries.join(" #{OR} ")
      end

      def respond_to_missing?(name, include_private = false)
        Query.public_method_defined?(name, false) || super
      end

      def method_missing(name, *args)
        if Query.respond_to?(name, false)
          self.queries += Query.send(name, *args)
        else
          super
        end
      end

    end
  end
end

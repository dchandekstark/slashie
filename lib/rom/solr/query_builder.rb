# frozen_string_literal: true

require 'rom/solr/query'

module ROM
  module Solr
    class QueryBuilder

      attr_reader :relation, :method_name

      def initialize(relation, method_name)
        @relation, @method_name = relation, method_name
      end

      Query.public_instance_methods.each do |name|
        define_method(name) do |*args|
          queries = Query.send(name, *args)

          relation.send(method_name, *queries)
        end
      end

    end
  end
end

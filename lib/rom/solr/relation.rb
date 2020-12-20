module ROM
  module Solr
    class Relation < ROM::HTTP::Relation
      adapter :solr

      forward :add_param_values, :default_params

      option :output_schema, default: ->{ NOOP_OUTPUT_SCHEMA }

      def count
        to_enum.count
      end

      def all
        self
      end

    end
  end
end

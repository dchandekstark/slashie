module ROM
  module Solr
    class Relation < ROM::HTTP::Relation

      adapter :solr

      schema { }

      # "schemaless" config - pass thru all tuples
      option :output_schema, default: -> { NOOP_OUTPUT_SCHEMA }

      forward :add_param_values, :default_params, :with_enum_on

      def fetch(*keys)
        with_enum_on(*keys).first
      end

    end
  end
end

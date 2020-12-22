module ROM
  module Solr
    class Relation < ROM::HTTP::Relation
      extend QueryParam
      extend PathMethod

      adapter :solr

      option :output_schema, default: ->{ NOOP_OUTPUT_SCHEMA }

      forward :add_param_values, :default_params

      query_param :wt
      query_param :fl

      def count
        to_enum.count
      end

    end
  end
end

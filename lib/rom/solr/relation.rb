module ROM
  module Solr
    class Relation < ROM::HTTP::Relation
      extend QueryParam

      adapter :solr

      option :output_schema, default: ->{ NOOP_OUTPUT_SCHEMA }

      forward :add_param_value, :default_params

      query_param :wt, type: Types::Coercible::String

      query_param :logParamsList, :log_params_list,
                  type: Types::String.optional

      def count
        to_enum.count
      end

    end
  end
end

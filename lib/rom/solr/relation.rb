require 'forwardable'

module ROM
  module Solr
    class Relation < ROM::HTTP::Relation

      extend Forwardable

      include Enumerable

      RESPONSE_WRITERS = %w[ csv geojson javabin json php phps python ruby smile velocity xlsx xml xslt ]

      def_delegators :dataset, :response, :params

      adapter     :solr
      auto_struct false
      auto_map    false

      # Need this?
      option :output_schema, default: ->{ NOOP_OUTPUT_SCHEMA }

      def wt(writer)
        add_params(wt: Types::Coercible::String.enum(*RESPONSE_WRITERS)[writer])
      end

      def log_params_list(*log_params)
        new_log_params = Types::Array.of(Types::String)[log_params]

        add_params(logParamsList: new_log_params.join(','))
      end

      def omit_header(omit = true)
        add_params(omitHeader: Types::Bool[omit])
      end

      def count
        to_enum.count
      end

    end
  end
end

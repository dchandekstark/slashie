require 'forwardable'

module ROM
  module Solr
    class Relation < ROM::HTTP::Relation
      extend Forwardable

      def_delegators :dataset, :response, :params

      adapter     :solr
      auto_struct false
      auto_map    false

      # Need this?
      option :output_schema, default: ->{ NOOP_OUTPUT_SCHEMA }

      def wt(format)
        add_params(wt: Types::Coercible::String[format])
      end
      alias_method :format, :wt

      def log_params_list(log_params)
        lplist = log_params.nil? ? nil : Array.wrap(log_params).join(',')

        add_params(logParamsList: lplist)
      end
      alias_method :log_params, :log_params_list

      def omit_header(omit = true)
        add_params(omitHeader: Types::Bool[omit])
      end

      def count
        to_enum.count
      end

    end
  end
end

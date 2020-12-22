module ROM
  module Solr
    class SelectRelation < Relation

      auto_struct false

      schema :select, as: :search do
        # no schema
      end

      # @override
      def each(&block)
        return to_enum unless block_given?

        SelectCursor.new(self).each(&block)
      end

      query_param :q, :query

      query_param :fq, :filter_query

      query_param :fl, :field_list

      query_param :cache, type: Types::Bool

      query_param :segmentTerminateEarly, :segment_terminate_early,
                  type: Types::Bool.default(true)

      query_param :timeAllowed, :time_allowed,
                  type: Types::Coercible::Integer

      query_param :explainOther, :explain_other

      query_param :omitHeader, :omit_header,
                  type: Types::Bool.default(true)

      query_param :start, type: Types::Coercible::Integer

      query_param :sort, :offset

      query_param :rows, :limit,
                  type: Types::Coercible::Integer

      query_param :defType, :def_type,
                  type: Types::Coercible::String

      query_param :debug,
                  type: Types::Coercible::String
                    .enum('query', 'timing', 'results', 'all', 'true')

      query_param :echoParams, :echo_params,
                  type: Types::Coercible::String
                    .default('explicit'.freeze)
                    .enum('explicit', 'all', 'none')

      query_param :minExactCount, :min_exact_count,
                  type: Types::Coercible::Integer

      def all
        q('*:*')
      end

      # @override Don't have to enumerate to get count (may not be exact)
      def count
        dataset.num_found
      end

    end
  end
end

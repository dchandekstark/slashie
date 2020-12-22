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

      query_param :q

      query_param :fq, repeatable: true

      query_param :fl, repeatable: true

      query_param :cache, type: Types::Bool

      query_param :segment_terminate_early,
                  param: :segmentTerminateEarly,
                  type: Types::Bool.default(true)

      query_param :time_allowed,
                  param: :timeAllowed,
                  type: Types::Coercible::Integer

      query_param :explain_other,
                  param: :explainOther

      query_param :omit_header,
                  param: :omitHeader,
                  type: Types::Bool.default(true)

      query_param :start, type: Types::Coercible::Integer

      query_param :sort

      query_param :rows, type: Types::Coercible::Integer

      query_param :def_type,
                  param: :defType,
                  type: Types::Coercible::String

      query_param :debug,
                  type: Types::Coercible::String
                    .enum('query', 'timing', 'results', 'all', 'true')

      query_param :echo_params,
                  param: :echoParams,
                  type: Types::Coercible::String
                    .default('explicit'.freeze)
                    .enum('explicit', 'all', 'none')

      query_param :min_exact_count,
                  param: :minExactCount,
                  type: Types::Coercible::Integer

      def filter(*fq)
        add_param_values(:fq, fq)
      end
      alias_method :fq, :filter

      def query(q)
        add_params(q: q)
      end
      alias_method :q, :query

      def fields(*fl)
        add_params(fl: fl)
      end
      alias_method :fl, :fields

      def start(offset)
        add_params(start: offset.to_i)
      end
      alias_method :offset, :start

      def rows(limit)
        add_params(rows: limit.to_i)
      end
      alias_method :limit, :rows

      # sort('title ASC', 'id ASC')
      def sort(*criteria)
        add_params(sort: criteria.join(','))
      end

      def resort(*criteria)
        params.delete(:sort)
        sort(*criteria)
      end

      # @override Don't have to enumerate to get count (may not be exact)
      def count
        dataset.num_found
      end

    end
  end
end

module ROM
  module Solr
    class SearchRelation < Relation

      auto_struct false

      schema(:select, as: :search) { }

      # @override
      def each(&block)
        return to_enum unless block_given?

        SelectCursor.new(self).each(&block)
      end

      def q(query)
        add_params(q: Types::String[query])
      end
      alias_method :query, :q

      def fq(*filter)
        add_params(fq: filter)
      end
      alias_method :filter, :fq

      def fl(*fields)
        add_params(fl: fields.join(','))
      end
      alias_method :fields, :fl

      def cache(enabled = true)
        add_params(cache: Types::Bool[enabled])
      end

      def segment_terminate_early(enabled = true)
        add_params(segmentTerminateEarly: Types::Bool[enabled])
      end

      def time_allowed(millis)
        add_params(timeAllowed: Types::Coercible::Integer[millis])
      end

      def explain_other(query)
        add_params(explainOther: Types::String[query])
      end

      def omit_header(omit = true)
        add_params(omitHeader: Types::Bool[omit])
      end

      def start(offset)
        add_params(start: Types::Coercible::Integer[offset])
      end

      def sort(*criteria)
        add_params(sort: criteria.join(','))
      end

      def rows(num)
        add_params(rows: Types::Coercible::Integer[num])
      end
      alias_method :limit, :rows

      def def_type(value)
        add_params(defType: Types::Coercible::String[value])
      end

      def debug(setting)
        type = Types::Coercible::String
                 .enum('query', 'timing', 'results', 'all', 'true')
        add_params(debug: type[setting])
      end

      def echo_params(setting)
        type = Types::Coercible::String
                 .default('explicit'.freeze)
                 .enum('explicit', 'all', 'none')
        add_params(echoParams: type[setting])
      end

      def min_exact_count(num)
        add_params(minExactCount: Types::Coercible::Integer[num])
      end

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

module ROM
  module Solr
    class SelectRelation < Relation

      schema :select, as: :search do
        # no schema
      end

      # @override
      def each(&block)
        return to_enum unless block_given?

        SelectCursor.new(self).each(&block)
      end

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

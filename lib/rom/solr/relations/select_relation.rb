module ROM
  module Solr
    class SelectRelation < Relation

      schemaless :select, as: :search

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

      def resort(crit)
        params.delete(:sort)
        sort(crit)
      end

      # sort(title: 'ASC', id: 'ASC')
      def sort(crit)
        sort_hash = params.fetch(:sort, '').split(/,\s*/).map(&:split).to_h
                      .transform_keys(&:to_sym)
                      .transform_values(&:upcase)
        crit_hash = crit.transform_keys(&:to_sym).transform_values(&:upcase)
        new_sort_hash = sort_hash.merge(crit_hash)
        new_sort = new_sort_hash.to_a.map { |a| a.join(' ') }.join(', ')
        add_params(sort: new_sort)
      end

      # @override Don't have to enumerate to get count (may not be exact)
      def count
        dataset.num_found
      end

    end
  end
end

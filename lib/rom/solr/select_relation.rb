require 'rom/solr/cursor'

module ROM
  module Solr
    class SelectRelation < Relation

      schema(:select) do
        attribute :id, ROM::Types::String
      end

      def filter(*fq)
        add_values(:fq, fq)
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

      def sort(crit)
        add_params(sort: crit)
      end

      def sort?
        dataset.param?(:sort)
      end

      def count
        dataset.num_found
      end

      def all
        query('*:*')
      end

      # @override
      def each
        return to_enum unless block_given?
        cursor.each { |doc| yield(doc) }
      end

      def cursor
        Cursor.new(dataset)
      end

    end
  end
end

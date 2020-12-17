module ROM
  module Solr
    class PaginatedDataset

      attr_reader :dataset

      def initialize(dataset)
        ds = dataset
               .default_params(rows: 20)
               .remove_params(:start)
               .add_params(cursorMark: '*')

        if ds.param?(:sort)
          unless ds.params[:sort] =~ /\bid\b/
            ds = ds.sort('%{sort},id ASC' % ds.params)
          end
        else
          ds = ds.sort('id ASC')
        end

        @dataset = ds
      end

      def each
        while true
          yield dataset
          break if last_page?
          @dataset = dataset.add_params(cursorMark: next_cursor_mark)
        end
      end

      def cursor_mark
        dataset.params[:cursorMark]
      end

      def next_cursor_mark
        dataset.response['nextCursorMark']
      end

      def page_size
        dataset.params[:rows]
      end

      def total_size
        dataset.num_found
      end

      def last_cursor?
        cursor_mark == next_cursor_mark
      end

      def one_page?
        total_size <= page_size
      end

      def last_page?
        one_page? || last_cursor?
      end

    end
  end
end

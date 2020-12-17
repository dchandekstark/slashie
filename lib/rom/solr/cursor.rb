module ROM
  module Solr
    class Cursor

      attr_reader :dataset

      def initialize(dataset)
        @dataset = dataset
                     .remove_params(:start)
                     .add_params(rows: 20, sort: 'id ASC', cursorMark: '*')
      end

      def each
        while true
          page.each { |doc| yield(doc) }
          break if last_page?
          update_cursor_mark
        end
      end

      def update_cursor_mark
        @dataset = dataset.add_params(cursorMark: next_cursor_mark)
      end

      def page
        dataset.docs
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

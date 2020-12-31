require 'delegate'

module ROM
  module Solr
    #
    # Wraps a DocumentsDataset to provide pagination with a cursor.
    #
    class SelectCursor < SimpleDelegator

      def initialize(dataset)
        params = { cursorMark: '*' }

        # Sort must include a sort on unique key (id).
        sort = dataset.params[:sort]
        unless /\bid\b/ =~ sort
          params[:sort] = Array.wrap(sort).append('id ASC').join(',')
        end

        super dataset.add_params(params)
      end

      def each(&block)
        return to_enum unless block_given?

        while true
          __getobj__.each(&block)

          break if last_page?

          move_cursor
        end
      end

      def cursor_mark
        params[:cursorMark]
      end

      def next_cursor_mark
        response[:nextCursorMark]
      end

      def last_page?
        cursor_mark == next_cursor_mark
      end

      def move_cursor
        __setobj__(next_page)
      end

      def next_page
        __getobj__.add_params(cursorMark: next_cursor_mark)
      end

    end
  end
end
